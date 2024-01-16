#include <stdio.h>

int najdi_posledny_znak(const char *retazec, char hladany_znak, int pocet_vyskytov) {
    int vyskyty = 0;
    int posledna_pozicia = -1;

    for (int i = 0; retazec[i] != '\0'; i++) {
        if (retazec[i] == hladany_znak) {
            vyskyty++;
            posledna_pozicia = i;
        }
    }

    if (vyskyty == pocet_vyskytov) {
        return posledna_pozicia;
    } else {
        return -1;
    }
}

int main() {
    const char *vstupny_retazec = "tralalafiala";
    char hladany_znak = 'a';
    int pocet_vyskytov = 3;

    int pozicia = najdi_posledny_znak(vstupny_retazec, hladany_znak, pocet_vyskytov);

    if (pozicia != -1) {
        printf("Znak '%c' sa vyskytuje presne %d-krát na pozícii %d.\n", hladany_znak, pocet_vyskytov, pozicia);
    } else {
        printf("Znak '%c' sa nevyskytuje presne %d-krát v reťazci.\n", hladany_znak, pocet_vyskytov);
    }

    return 0;
}
