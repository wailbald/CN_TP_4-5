/******************************************/
/* tp2_poisson1D_direct.c                 */
/* This file contains the main function   */
/* to solve the Poisson 1D problem        */
/******************************************/
#include "lib_poisson1D.h"
int main(int argc,char *argv[])
/* ** argc: Number of arguments */
/* ** argv: Values of arguments */
{
  int ierr;
  int jj;
  int nbpoints, la;
  int ku, kl, kv, lab;
  int *ipiv;
  int info;
  int NRHS;
  double T0, T1;
  double *RHS, *RHS2, *EX_SOL, *X;
  double *AB;

  double temp, relres;

  NRHS=1;
  nbpoints=102;
  la=nbpoints-2;
  T0=-5.0;
  T1=5.0;

  printf("--------- Poisson 1D ---------\n\n");
  RHS=(double *) malloc(sizeof(double)*la);
  RHS2=(double *) malloc(sizeof(double)*la);
  EX_SOL=(double *) malloc(sizeof(double)*la);
  X=(double *) malloc(sizeof(double)*la);

  set_grid_points_1D(X, &la);
  set_dense_RHS_DBC_1D(RHS,&la,&T0,&T1);
  set_dense_RHS_DBC_1D(RHS2,&la,&T0,&T1);
  set_analytical_solution_DBC_1D(EX_SOL, X, &la, &T0, &T1);
  
  write_vec(RHS, &la, "RHS.dat");
  write_vec(EX_SOL, &la, "EX_SOL.dat");
  write_vec(X, &la, "X_grid.dat");

  kv=1;
  ku=1;
  kl=1;
  lab=kv+kl+ku+1;

  AB = (double *) malloc(sizeof(double)*lab*la);

  info=0;

  double alpha = 1.0;
  double beta = 0.0;
  double incx = 1.0;
  double incy = 1.0;

  double *y = malloc(la * sizeof(double));

  /* working array for pivot used by LU Factorization */
  ipiv = (int *) calloc(la, sizeof(int));

  int row = 1; //

  if (row == 1){ // LAPACK_ROW_MAJOR
    double *AB2 = malloc(sizeof(double)*lab*la);

    set_GB_operator_rowMajor_poisson1D(AB, &lab, &la, &kv);

    write_GB_operator_rowMajor_poisson1D(AB, &lab, &la, "AB_row.dat");

    info = LAPACKE_dgbsv(LAPACK_ROW_MAJOR,la, kl, ku, NRHS, AB, la, ipiv, RHS, NRHS);
    
    free(AB);

    kv = 0; 
    lab = kl+ku+kv+1;

    AB = malloc(sizeof(double)*lab*la);

    set_GB_operator_colMajor_poisson1D(AB, &lab, &la, &kv);

    cblas_dgbmv(CblasRowMajor, CblasNoTrans, la, la, kl, ku, alpha, AB, lab, EX_SOL, incx, beta, y, incy);

    temp = cblas_ddot(la, y, 1, y,1);
    temp = sqrt(temp);
    cblas_daxpy(la, -1.0, y, 1, RHS2, 1);
    relres = cblas_ddot(la, RHS2, 1, RHS2,1);
    relres = sqrt(relres);
    relres = relres / temp;
    printf("\nThe relative residual error of dgbmv is relres = %e\n",relres);

    set_GB_operator_rowMajor_poisson1D(AB2, &lab, &la, &kv);

    double *L = malloc(sizeof(double)*lab*la);
    double *U = malloc(sizeof(double)*lab*la);
    double *R = malloc(sizeof(double)*lab*la);

    facto_lu(AB2, la);

    get_lu(AB2, U, L, la);

    mul_matLU_GB(U, L, R, la);

    set_GB_operator_rowMajor_poisson1D(AB2, &lab, &la, &kv);

    sub_mat_GB(AB2, R, U, la);

    write_GB_operator_rowMajor_poisson1D(U, &lab, &la, "A-LU.dat");

    free(AB2);
    free(L);
    free(U);
    free(R);
  } 

  else { // LAPACK_COL_MAJOR
    set_GB_operator_colMajor_poisson1D(AB, &lab, &la, &kv);

    write_GB_operator_colMajor_poisson1D(AB, &lab, &la, "AB_col.dat");

    info = LAPACKE_dgbsv(LAPACK_COL_MAJOR,la, kl, ku, NRHS, AB, lab, ipiv, RHS, la);
  
    free(AB);

    kv = 0;

    lab = ku+kl+kv+1;

    AB = (double *) malloc(sizeof(double)*lab*la);

    set_GB_operator_colMajor_poisson1D(AB, &lab, &la, &kv);

    cblas_dgbmv(CblasColMajor, CblasNoTrans, la, la, kl, ku, alpha, AB, lab, EX_SOL, incx, beta, y, incy);

    temp = cblas_ddot(la, y, 1, y,1);
    temp = sqrt(temp);
    cblas_daxpy(la, -1.0, y, 1, RHS2, 1);
    relres = cblas_ddot(la, RHS2, 1, RHS2,1);
    relres = sqrt(relres);
    relres = relres / temp;
    printf("\nThe relative residual error of dgbmv is relres = %e\n",relres);

    write_vec(y, &la, "Y_col.dat");
  }    

  
  printf("\n INFO DGBSV = %d\n",info);

  write_xy(RHS, X, &la, "SOL.dat");

  /* Relative residual */
  temp = cblas_ddot(la, RHS, 1, RHS,1);
  temp = sqrt(temp);
  cblas_daxpy(la, -1.0, RHS, 1, EX_SOL, 1);
  relres = cblas_ddot(la, EX_SOL, 1, EX_SOL,1);
  relres = sqrt(relres);
  relres = relres / temp;
  
  printf("\nThe relative residual error is relres = %e\n",relres);

  free(RHS);
  free(EX_SOL);
  free(X);
  free(AB);
  free(ipiv);

  printf("\n\n--------- End -----------\n");
}
