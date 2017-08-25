/*
   match_set.c
   
   This program calculates all sums of the numbers in one value set (x)
   and compares each sum with the numbers in another value set (y).
   The purpose is to find all sums that matches.

   Compiled with 'gcc -o match_set match_set.c' and tested with
   different values in x and y.
*/

#include <stdio.h>
#include <string.h>
#include <math.h>

#define MAX 1000

/*  Program arguments on command line, first file for x and second for y.  */
int main( int argc, char *argv[] ) {

    FILE    *fi;
    int     nx, ix, jx, X = -1, Y = -1, number_of_matches = 0;
    float   x[MAX] = {}, y[MAX] = {}, sum;
    char    sum_string[MAX], tmp_string[16];

    /*  Search through the second value set and see if we have match(es).  */
    void check_match( const float s, const char *string ) {
        int ny;
        for ( ny = 0; ny < Y; ny++ ) {
            if ( s == y[ny] ) {
                printf( "%s=y[%d]=%.2f\n", string, ny+1, y[ny] );
                ++number_of_matches;
            }
        }
    }

    /*  Read all the values from files.  */
    if ( argc != 3 ) {
        printf("Usage: %s data-file data-file\n", argv[0] );
        return -1;
    }
    if ( ( fi = fopen(argv[1], "r") ) == NULL ) {
        printf("Could not open %s!", argv[1] );
        return -2;
    }
    while ( ++X < MAX && fscanf( fi, "%f", &x[X]) == 1 );
    if ( X == MAX )
        printf("Warning! Could not read all values from %s.\n", argv[1] );
    fclose(fi);
    if ( ( fi = fopen(argv[2], "r") ) == NULL ) {
        printf("Could not open %s!", argv[2] );
        return -3;
    }
    while ( ++Y < MAX && fscanf( fi, "%f", &y[Y]) == 1 );
    if ( Y == MAX )
        printf("Warning! Could not read all values from %s.\n", argv[2] );
    fclose(fi);

    /*  Show the contents of the vaule sets before calculating sums.  */
    printf("--- Values for sums to match:\n" );
    for ( nx = 0; nx < X; nx++ )
        printf("x[%d]=%.2f, ", nx+1, x[nx] );
    printf("\b\b  \n");
    printf("--- Values to match with:\n" );
    for ( nx = 0; nx < Y; nx++ )
        printf("y[%d]=%.2f, ", nx+1, y[nx] );
    printf("\b\b  \n");
    printf("--- Please wait, calculating sums...\n");

    /*  Loop through the first value set.  */
    for ( nx = 0; nx < X; nx++ ) {
        sum = x[nx];
        sprintf( sum_string, "x[%d]", nx+1 );
        check_match( sum, sum_string );
        for ( ix = 1; ix < X; ix++ ) {
            sum = x[nx];
            sprintf( sum_string, "x[%d]", nx+1 );
            for ( jx = nx+ix; jx < X; jx++ ) {
                sum += x[jx];
                sprintf( tmp_string, "+x[%d]", jx+1 );
                strcat( sum_string, tmp_string );
                check_match( sum, sum_string );
            }
        }
    }
    printf("--- ...done! Found %d matches.", number_of_matches );

}


