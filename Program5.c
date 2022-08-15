#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>
char stack[30], expr[30], arr[30], temp[30];
int i,j,k=0,l,r;

void push()
{
	arr[i] = expr[k];
	i++;
}

void dispinp()
{
	printf("\t\t\t");
	for(k=0;k<strlen(expr);k++)
		printf("%c", expr[k]);
	printf("$");
}

void dispstk()
{
	printf("\n");
	for(k=0;k<strlen(stack);k++)
		printf("%c", stack[k]);
}

void assign()
{
	stack[++j] = arr[i];
	expr[i] = ' ';
	dispstk;
	dispinp;
}

int main()
{
	printf("\t\t\t\t Shift Reduce Parser\n");
	printf("The Grammar is E->E+E|E-E|E*E|i\n");
	printf("Enter the expression");
	gets(expr);
	printf("\nSTACK\t\t\tINPUT\t\t\tACTION\n");
	printf("\n$");
	dispinp();
	printf("\t\t\tShift");
	for(k=0;k<strlen(expr);k++)
	{
		push();
	}
	stack[0] = '$';
	for(i=0;i<strlen(expr);i++)
	{
		switch(arr[i])
		{
			case 'i': assign();
				printf("\t\t\tReduce E->i");
				stack[j] = 'E';
				dispinp();
				dispstk();
				if(arr[i+1]!='\0')
					printf("\t\t\tShift");
				break;
			case '+': assign();
				printf("\t\t\tShift");
				break;
			case '-': assign();
				printf("\t\t\tShift");
				break;
			case '*': assign();
				printf("\t\t\tShift");
				break;
			default: printf("\nString is not accepted\n");
				return(0);
				break;
		}
	}
	l = strlen(stack);
	while(l>2)
	{
		r=0;
		for(i=l-1;i>=l-3;i--)
		{
			temp[r] = stack[i];
			r++;
		}
		temp[r] = NULL;
		if((strcmp(temp,"E+E")==0)||(strcmp(temp,"E-E")==0)||(strcmp(temp,"E*E")==0))
		{	
			for(i=l-1;i>l-3;i--)
			{
				stack[i] = ' ';
			}
			stack[l-3] = 'E';
			printf("\t\t\tReduce E->");
			for(i=0;i<strlen(temp);i++)
			{
				printf("%c", temp[i]);
			}
			dispstk();
			dispinp();
			l=l-2;
		}
		else
		{
			printf("\nString is not accepted\n");
			return 0;
		}
	}
	printf("\t\t ACCEPTED");
	return 0;
}
			
