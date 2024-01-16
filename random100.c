#include <stdio.h>
#include <stdlib.h>

#define SIZE 100

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int main() {
    int numbers[SIZE];
    int searchNumber, position;

    //Generation of 100 random numbers ranging from 0 to 100000
    for (int i = 0; i < SIZE; i++) {
        numbers[i] = rand() % 100001;
    }

    // Arrangement of numbers
    qsort(numbers, SIZE, sizeof(int), compare);

    // Selecting the first number as the searched number
    searchNumber = numbers[0];

    // Listing of numbers five by five in a row
    printf("Arranged numbers:\n");
    for (int i = 0; i < SIZE; i++) {
        printf("%6d ", numbers[i]);
        if ((i + 1) % 5 == 0) {
            printf("\n");
        }
    }

    // Finding the position of the searched number by binary search
    int low = 0, high = SIZE - 1;
    while (low <= high) {
        int mid = (low + high) / 2;
        if (numbers[mid] == searchNumber) {
            position = mid;
            break;
        } else if (numbers[mid] < searchNumber) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    // Listing the position of the searched number
    printf("\nPositions of the search number %d je: %d\n", searchNumber, position);

    return 0;
}