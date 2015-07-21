#include <stdio.h>

/*
 *  print data items
 */
void
print(int n, int *data) {
    int i;
    printf("number of data: %d\n", n);
    for (i = 0; i < n; i++) {
        printf("%d ", data[i]);
    }
    printf("\n");
}

/*
 *  sort routine (bubble sort)
 */
int *
sort(int n, int *data) {
    int i, j;

    for (i = 0; i < n - 1; i++) {
        for (j = n - 2; j >= i; j--) {
            if (data[j] < data[j + 1]) {
                int tmp = data[j];
                data[j] = data[j + 1];
                data[j + 1] = tmp;
            }
        }
    }
    return data;
}

int
main(int argc, char *argv[]) {
    int data[] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, };
    int n_data = 8; /* number of data */
    int *sorted_data = sort(n_data, data);

    /* print soted data */
    print(n_data, sorted_data);
}

/* end of file (sort_bubble1.c) */

