%{

#include <stdio.h>
#include <stdlib.h>

extern FILE *fp;

%} 

%start Code
%token INTEGER REAL CHARACTER 
%token LOOP RETURN QUOTE
%token IF ELSE ELIF
%token INTEGER_VALUE NAME REAL_VALUE STRING
%token USE METHODS START
%token SWITCH CASE DEFAULT
%token NOT TRUE FALSE AND OR
%token LESS_THAN GREATER_THAN LESS_THAN_EQUAL_TO GREATER_THAN_EQUAL_TO 
%token EQUAL_TO NOT_EQUAL_TO

%right '='
%left AND OR
%left LESS_THAN_EQUAL_TO GREATER_THAN_EQUAL_TO EQUAL_TO 
%left NOT_EQUAL_TO LESS_THAN GREATER_THAN

%%

Code                   :   USE LESS_THAN Use_Stmts GREATER_THAN METHODS LESS_THAN Method_Def GREATER_THAN START LESS_THAN Statements GREATER_THAN
		                   ;

Use_Stmts              :  NAME ';' Use_Stmts
			                 |
			                 ;

Method_Def             :  NAME '(' Parameters ')' '{' Statements '}' Method_Def
                       |
                       ;

Statements             :  Statement ';' Statements 
                       |  Looping_Stmt Statements
                       |  Conditional_Stmt Statements
                       |
                       ;

Parameters             :  Parameter ',' Parameters
                       |  Parameter
                       ;

Parameter              :  Datatype NAME
                       ;

Datatype               :  INTEGER
                       |  REAL
                       |  CHARACTER
                       ;

Statement              :   Assignment_Stmt
                       |   Declaration_Stmt
                       |   Method_Call_Stmt
                       |   Return_Stmt
                       ;

Return_Stmt            :   RETURN Value
                       ;

Declaration_Stmt       :   Datatype Name_List
                       ;

Name_List              :   NAME '=' Assign ',' Name_List
                       |   NAME ',' Name_List
                       |   NAME '=' Assign
                       |   NAME

Assign                 :   Value
                       ;

Value                  :   NAME
                       |   INTEGER_VALUE
                       |   REAL_VALUE
                       ;


Assignment_Stmt        :   NAME '=' Value 
                       |   Array_Assign_Stmt
                       |   NAME '=' Arithmetic_Expression 
                       |   NAME '=' Boolean_Expression
                       |   NAME '=' STRING
                       |   NAME '=' Method_Call_Stmt 
                       ;

Array_Assign_Stmt      :   NAME '[' Index ']' '=' Value 
                       |   NAME '[' Index ']' '=' STRING
                       ;                        

Index                  :   NAME
                       |   INTEGER_VALUE
                       ;

Conditional_Stmt       :   If_Stmt
                       |   Switch_Stmt
                       ;

If_Stmt                :   IF '(' Expression ')' '{' Statements '}' Elif ELSE '{' Statements '}'
                       |   IF '(' Expression ')' '{' Statements '}' Elif
                       ;

Elif                   :   ELIF '(' Expression ')' '{' Statements '}' Elif
                       |
                       ;

Switch_Stmt            :   SWITCH '(' NAME ')' '{' Case_Stmt Default_Stmt '}'
                       ;

Case_Stmt              :   CASE INTEGER_VALUE ':' Statements Case_Stmt
                       |
                       ;

Default_Stmt           :   DEFAULT ':' Statements 
                       |
                       ;

Expression             :   Arithmetic_Expression
                       |   Boolean_Expression
                       ;

Arithmetic_Expression  :   Term Operator1 Arithmetic_Expression
                       |   Term
                       ;

Term                   :   Factor Operator2 Term
                       |   Factor
                       ;

Factor                 :   '(' Arithmetic_Expression ')'
                       |   Value
                       ;

Operator1              :   '+'
                       |   '-'
                       ;

Operator2              :   '*'
                       |   '/'
                       ;

Boolean_Expression     :   Boolean_Expression Logical_Operator Boolean_Expression
                       |   '(' Boolean_Expression ')'
                       |   Arithmetic_Expression Relational_Operator Arithmetic_Expression
                       |   NOT Boolean_Expression
                       |   TRUE
                       |   FALSE
                       ;

Logical_Operator       :   AND
                       |   OR
                       ;

Relational_Operator    :   LESS_THAN 
                       |   GREATER_THAN 
                       |   LESS_THAN_EQUAL_TO 
                       |   GREATER_THAN_EQUAL_TO  
                       |   EQUAL_TO 
                       |   NOT_EQUAL_TO  
                       ;


Looping_Stmt           :   LOOP '(' Boolean_Expression ')' '{' Statements '}'
                       ;

Method_Call_Stmt       :   NAME '=' NAME '(' Parameter_Names ')'
                       |   NAME '(' Parameter_Names ')' 
                       |   NAME '(' STRING ')'
                       ;

Parameter_Names        :   NAME ',' Parameter_Names
                       |   NAME
                       |
                       ;


%%

#include"lex.yy.c"
#include<ctype.h>
int count = 0;
int main(int argc, char *argv[])
{
	yyin = fopen(argv[1], "r");
	
   if(!yyparse())
		printf("\nParsing complete\n");
	else
		printf("\nParsing failed\n");
	
	fclose(yyin);
    return 0;
}
         
int yyerror(char *s) {
    fprintf(stderr, "Error: %s / %s / %d\n", s, yytext, yylineno);
    return 0;
}                                                  









