#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <sys/time.h> //including libraries

void aleatorio(int *a,int size, int i) //funcion para crear los numeros aleatorios
{
    srand(time(NULL));
    for(i=0; i<size; i++)
    {
        a[i]=rand();
    }
}
int my_compare (const void * a, const void * b)//funcion ayudante para qsort
{
    int _a = *(int*)a;
    int _b = *(int*)b;
    if(_a < _b) return -1;
    else if(_a == _b) return 0;
    else return 1;
}
int main()
{
    int i=0, size;// size-the number of numbers in array, i - variable for the iteration
    struct timeval ti1, tf1, ti2, tf2, ti3, tf3; // Variables for checking the time of every action with gettimeofday;
    double tiempo1,tiempo2, tiempo3; //variables for storing time
    char str[100];//variable para la respuesta en menu
    printf("el tamany de int es:%d\n",sizeof(int));
    printf("Program creaOrdena, select mode:\n1)creaOrdena - crea fichero1\n2)creaOrdena - ordena fichero1\nWrite \"crea\" or \"ordena\"\n");
    fgets(str,sizeof str, stdin);//menu para selecionar el modo

   int *a; //= malloc(size*sizeof(int));//function for creating the random numbers

    if(!strncmp(str,"crea",4))
    {
        //dynamic memory allocation

        printf("How many random numbers do you want to get?\n");
        scanf("%d",&size);\
        a= malloc(size*sizeof(int));//function for creating the random numbers
        if(size>10000000L)
        {
            printf("The number is too big");
            exit(0);
        }

        //getting the random numbers with the function

        gettimeofday(&ti1,NULL);
        aleatorio(a,size,i);//getting the random numbers
        gettimeofday(&tf1,NULL);
        tiempo1=(double)((tf1.tv_sec - ti1.tv_sec)*1000 + (tf1.tv_usec - ti1.tv_usec)/1000.0);

        //Opening the file

        gettimeofday(&ti2,NULL);
        FILE *fp;
        fp = fopen("fichero1.txt", "w+");//abrir el fichero1
        if(fp==NULL)
        {
            printf("Impossible to open the file fichero.1\n");
        }
        gettimeofday(&tf2,NULL);
        tiempo2=(double)((tf2.tv_sec - ti2.tv_sec)*1000 + (tf2.tv_usec - ti2.tv_usec)/1000.0);


        //printing the data into file

        gettimeofday(&ti3,NULL);
        for(i=0; i<size; i++)
        {
            fprintf(fp,"%d,",a[i]);
        }
        fclose(fp);
        gettimeofday(&tf3,NULL);
        tiempo3=(double)((tf3.tv_sec - ti3.tv_sec)*1000 + (tf3.tv_usec - ti3.tv_usec)/1000.0);;

        //writing out the times

        printf("Time for getting %d random numbers  is %f miliseconds\n",size, tiempo1);
        printf("Time for opening the files is %f miliseconds.\n",tiempo2);
        printf("Time for putting the numbers into the file is %f miliseconds.",tiempo3);

        free(a);
    }

    //function for creating  order

    else if(!strncmp(str,"ordena",6))
    {
        //Dynamic memory allocation

        printf("How many numbers would like to read and sort?\n");
        scanf("%d",&size);
        a = malloc(size*sizeof(int));

        //opening a file fichero1.txt

        gettimeofday(&ti1,NULL);
        FILE *fp;
        fp = fopen("fichero1.txt","r");
        if(fp==NULL)
        {
            printf("This file fichero1.txt does not exist!");
            exit(-1);
        }

        //reading the random numbers from the file fichero1.txt

        for(i=0; i<size; i++)
        {
            fscanf(fp,"%d,",&a[i]);
        }
        fclose(fp);
        gettimeofday(&tf1,NULL);
        tiempo1=(double)((tf1.tv_sec - ti1.tv_sec)*1000 + (tf1.tv_usec - ti1.tv_usec)/1000.0);

//        printf("Before qsort:\n");
//        for(i=0; i<size; i++)
//        {
//            printf("%d ",a[i]);
//        }
//        printf("\n\n");

        //sorting the random numbers with qsort

        gettimeofday(&ti2,NULL);
        qsort(a, size, sizeof(int), my_compare);
        gettimeofday(&tf2,NULL);
        tiempo2=(double)((tf2.tv_sec - ti2.tv_sec)*1000 + (tf2.tv_usec - ti2.tv_usec)/1000.0);

        //printing the sorted numbers on the screen

        gettimeofday(&ti3,NULL);
        printf("After qsort:\n");
        for(i=0; i<size; i++)
        {
            printf("%d ",a[i]);
        }
        gettimeofday(&tf3,NULL);
        printf("\n\n");
        tiempo3=(double)((tf3.tv_sec - ti3.tv_sec)*1000 + (tf3.tv_usec - ti3.tv_usec)/1000.0);

        //writing out the values of times

        printf("Time for reading %d random numbers  is %f miliseconds.\n",size, tiempo1);
        printf("Time for sorting %d random numbers  is %f miliseconds.\n",size, tiempo2);
        printf("Time for writing the results on the screen is %f miliseconds.\n",tiempo3);
        printf("\n\n");
    }

    else
        printf("Please write \"crea\" or \"ordena\" in the menu!");
    return 0;
}
