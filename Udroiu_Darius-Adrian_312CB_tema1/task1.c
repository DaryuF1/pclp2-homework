// Udroiu Darius-Adrian, 312CB
#include <stdio.h>
#include <stdlib.h>

int coord(int x) // functie care determina directia pe baza bitilor de activare
{
	if (x & 8)
		return 0; // VEST
	if (x & 4)
		return 1; // SUD
	if (x & 2)
		return 2; // EST
	if (x & 1)
		return 3; // NORD
	return -1; // FARA DIRECTIE
}

int is_ok(int x, int d) // functie care ma asigura ca ma pot deplasa si ca nu e perete in directia pe care vreau sa ma duc
{
	if (d == 0 && (x & 8)) // VEST
		return 0;
	if (d == 1 && (x & 4)) // SUD
		return 0;
	if (d == 2 && (x & 2)) // EST
		return 0;
	if (d == 3 && (x & 1)) // NORD
		return 0;
	return 1;// DRUM LIBER
}

int inmat(int i, int j, int n, int m) // functie care verifica daca sunt in matrice
{
	return i >= 0 && i < n && j >= 0 && j < m;
}

void solve_itinerary(int rows, int cols, int matrix[rows][cols], int start_x, int start_y, unsigned char *instrs, int num_instrs)
{
	// vectori de directie
	const int di[] = {0, 1, 0, -1},
			  dj[] = {-1, 0, 1, 0};
	// vector de frecventa pt. instructiuni
	int *f = malloc(num_instrs * sizeof(int));
	if (!f) {
		printf("Eroare de alocare"); // daca nu s a alocat afisez mesajul si  ies din program
		return;
	}
	int i = 0;

make_0: // // facem elementele vectorului de frecventa nule cu un loop
	f[i] = 0;
	if (i < num_instrs - 1) {
		i++;
		goto make_0;
	}
	i = 0;
loop_solve:
	{
		// decodificam instructiunea
		int idk = (instrs[i] >> 4) & 0xF;
		int d = coord(instrs[i] & 0xF);
		if (d == -1) { // daca instructiunea e invalida trecem mai departe
			i++;
			if (i < num_instrs)
				goto loop_solve;
			else
				goto end;
		}
		if (!f[i]) { // daca nu am folosit instructiunea
			if (idk & 8) {
				f[i] = 1;
				i -= (idk & 7);
				if (i < 0) {
					i = 0;
				}
				goto loop_solve;
			} else if (idk) { // daca idk > 0 repetam miscarea de idk ori
				int j = idk;
loop_j:
				if (is_ok(matrix[start_x][start_y], d)) {
					int dx = start_x + di[d],
						dy = start_y + dj[d];
					if (inmat(dx, dy, rows, cols)) {
						start_x = dx;
						start_y = dy;
					}
				}
				j--;
				if (j > 0)
					goto loop_j;
				i++;
				if (i < num_instrs)
					goto loop_solve;
				else
					goto end;
			}
		}
		if (is_ok(matrix[start_x][start_y], d)) { // efectuez o miscare basic
			int dx = start_x + di[d],
				dy = start_y + dj[d];
			if (inmat(dx, dy, rows, cols)) {
				start_x = dx;
				start_y = dy;
			}
		}
		i++;
		if (i < num_instrs)
			goto loop_solve;
	}
end:
	printf("(%d, %d) ", start_y, start_x); // afisam coordonatele cerute
	free(f);
}

int main()
{
// citim datele de intrare	
	int n, m;
	scanf("%d%d", &n, &m);
	int a[n][m];
	int i = 0, j = 0;
loop1:
	j = 0;
loop2:
	scanf("%d", &a[i][j]);
	if (j < m - 1) {
		j++;
		goto loop2;
	} else if (i < n - 1) {
		i++;
		goto loop1;
	}
	int x, y, k;
	scanf("%d%d%d", &x, &y, &k);
	unsigned char *v = malloc(k * sizeof(unsigned char));
	if (!v) {
		printf("Eroare de alocare");
		return 0;
	}
	i = 0;
loop3:
	scanf("%hhu", &v[i]);
	if (i < k - 1) {
		i++;
		goto loop3;
	}
	solve_itinerary(n, m, a, x, y, v, k);
	free(v);
	return 0;
}
