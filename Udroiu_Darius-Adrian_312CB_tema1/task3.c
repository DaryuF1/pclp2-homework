// Udroiu Darius-Adrian, 312CB
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

void get_items(void *suitcase, int *indices, int num_indices) 
{
    int n = *(int *)suitcase; // primii 4 octecti contin nr. total de el. stocaye
    uint32_t *o = (uint32_t *)((char *)suitcase + sizeof(int));
    uint8_t *t = (uint8_t *)((char *)o + n*sizeof(uint32_t));
    void *d = (char *)t + n*sizeof(uint8_t);
    int i = 0;
loop:
    if(i==num_indices)
        goto fi;
        int idk = indices[i]; // indicile elementului cautat
        void *ptr = (char *)d + o[idk]; // calculam adresa exacta
        uint8_t k = t[idk]; // identificam ce tip de data e

        // identificam tipul si afisam ptr in functie de tipul de data gasit
        if (k == 1) {
            printf("%c", *(char *)ptr);
            goto print_line;

        } else if (k == 2) {
            printf("%d", *(int *)ptr);
            goto print_line;

        } else if (k == 3) {
            if(strcmp((char *)ptr,"\"\"") == 0) // inseamna ca e caracterul null si nu mai afisam inca o data ghilimelele
                printf("%s", (char *)ptr);
           else {
                printf("\"%s\"", (char *)ptr);
                goto print_line;
           }

        } else if (k == 4) { 
            printf("0x%02X", *(uint8_t *)ptr);
            goto print_line;

        } else if (k == 5) {
            printf("0x%04X", *(uint16_t *)ptr);
                goto print_line;
        }
    print_line:
        if (i < num_indices - 1)
            printf("\n");
    i++;
    goto loop;
fi:
        return;
}

int main()
{
    int n;
    scanf("%d",&n);
    void *suitcase = malloc(1<<12); // alocam un bufer de 4kb
    *(int *)suitcase = n; // slavam nr. de el. la inceputul buferului
    uint32_t *o = (uint32_t *)((char *)suitcase + sizeof(int));
    uint8_t *t = (uint8_t *)((char *)o + n*sizeof(uint32_t));
    void *d = (char *)t + n*sizeof(uint8_t);
    uint32_t co = 0; // ne arata unde ne aflam
    int i = 0;

loop:
    if(i==n)
        goto end1;
    int k;
    scanf("%d",&k);
    t[i] = (uint8_t) k;
    o[i] = co;
    // citim datele si in functie de tipul lor si le punem in suitcasae
    if (k == 1) {
        char val;
        scanf(" %c", &val);
        memcpy((char *)d + co, &val, sizeof(char));
        co += sizeof(char);
    } else if (k == 2) {
        int val;
        scanf("%d", &val);
        memcpy((char *)d + co, &val, sizeof(int));
        co += sizeof(int);
    } else if (k == 3) {
        int len;
        char temp[256];
        scanf("%d %s", &len, temp);
        memcpy((char *)d + co, temp, strlen(temp) + 1);
        co += strlen(temp) + 1;
    } else if (k == 4) {
        unsigned int val;
        scanf("%x", &val);
        uint8_t b = (uint8_t)val;
        memcpy((char *)d + co, &b, sizeof(uint8_t));
        co += sizeof(uint8_t);
    } else if (k == 5) {
        unsigned int val;
        scanf("%x", &val);
        uint16_t s = (uint16_t)val;
        memcpy((char *)d + co, &s, sizeof(uint16_t));
        co += sizeof(uint16_t);
    }
    i++;
    goto loop;

end1: ;
int q;
scanf("%d", &q);
int *qq = malloc(q * sizeof(int));
i = 0;
loop1:
    if(i==q)
        goto end2;
    scanf("%d",&qq[i]);
    i++;
    goto loop1;

end2:
    get_items(suitcase, qq, q); // apelam functia de solve
 //eliberam ce am alocat
    free(suitcase);
    free(qq);

    return 0;
}