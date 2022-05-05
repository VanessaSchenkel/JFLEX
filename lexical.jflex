/* USER CODE */
import java.util.*;
import java.io.*;

%%
/* OPTIONS AND DECLARATIONS */
%class LexicalAnalyzer
%public
%standalone //creates main function in generated class that expects name input
%line
%column

ADDRESS					                = "&"
ARITH_OP				                = ("+"|"-"|"/")
BLOCK_COMMENT			              = ("/*"((\*+[^/*])|([^*]))*\**"*/")
COMMA					                  = ","
DIGIT					                  = [0-9]
DECREMENT_OP			              = "--"
EQUAL					                  = "="
FLOAT					                  = {DIGIT}+"."+{DIGIT}*
ID 						                  = [a-zA-Z][a-zA-Z0-9]*
INCREMENT_OP			              = "++"
INCLUDE					                = ("#".+">")
LOGIC_OP				                = ("&&"|"||")
L_PAREN					                = "("
L_BRACKET				                = "["
L_BRACE					                = "{"
R_PAREN					                = ")"
R_BRACKET				                = "]"
R_BRACE 				                = "}"
SEMICOLON				                = ";"
RESERVED_WORD_DECLARATION       = (int|float|double|string|bool|void)
RESERVED_WORD_POINTER	          = ("*"|"*(")
RESERVED_WORD			              = (switch|return|break|NULL)
RESERVED_WORD_SCOPE             = (do|if|else|while|for|case)
RELATIONAL_OP			              = ("<"|"<="|"=="|"!="|">="|">")
SINGLE_LINE_COMMENT 	          = ("//".+"\n")
STRING					                = (\"[^\n]+\")

%{
  boolean isDeclaration = false; 
  boolean newSubcope = false; 
  boolean isThereSubscope = false; 

  int varCount = 0;
  int scopeCount = 0;
  int braceCounter = 0;
  int braceCounterSubscope = 0;

  public class Subscope {
    public boolean isClosed; 

    public boolean getIsClosed(){
      return this.isClosed;
    }

    public void setIsClosed(boolean isClosed){
      this.isClosed = isClosed;
    }
  }

  public class Scope {
    ArrayList<Subscope> subscope = new ArrayList<Subscope>();
    public boolean isClosed;
    public boolean isLibrary;
    public int subscopeCount;

    public Subscope getSubscope(int i){
      return this.subscope.get(i);
    }

    public void setSubscope(int i, boolean value){
      Subscope subscope = new Subscope();
      subscope.setIsClosed(value);
      this.subscope.add(i, subscope);
    }

    public boolean getIsClosed(){
      return this.isClosed;
    }

    public void setIsClosed(boolean isClosed){
      this.isClosed = isClosed;
    }

    public boolean getIsLibrary(){
      return this.isLibrary;
    }

    public void setIsLibrary(boolean isLibrary){
      this.isLibrary = isLibrary;
    }

    public int getSubscopeCount(){
      return this.subscopeCount;
    }
    
    public void setSubscopeCount(int subscopeCount){
      this.subscopeCount = subscopeCount;
    }
  }

  class Variables {
    String value;
    public int scope;
    public int subscope;

    public String getValue(){
      return this.value;
    }

    public void setValue(String value){
      this.value = value;
    }

    public int getScope(){
      return this.scope;
    }

    public void setScope(int scope){
      this.scope = scope;
    }

    public int getSubscope(){
      return this.subscope;
    }

    public void setSubscope(int subscope){
      this.subscope = subscope;
    }

}

  ArrayList<Scope> scopes = new ArrayList<Scope>();
  ArrayList<Variables> dictionary = new  ArrayList<Variables>();

  public void checkScope(){
	if(braceCounter == 0){
		//closing the current scope
		scopes.get(scopeCount).setIsClosed(true);
	}
	else if(braceCounterSubscope == braceCounter){
		//closing the current subscope
		int subscopeID = scopes.get(scopeCount).getSubscopeCount();
		scopes.get(scopeCount).getSubscope(subscopeID).setIsClosed(true);	
		isThereSubscope = false;
	}
}

public void checkPointer(){
	boolean isPointer = yytext().equals("*(");

	if(isPointer) {//it'is a pointer and a L_paren
		System.out.println("[Pointer, *]");
		System.out.println("[L_Paren, (]");
		return;
	}
	
	if(isDeclaration){ //so it's a pointer
		System.out.printf("[Pointer, %s]\n", yytext());
		isDeclaration = false;
		return;
	}
	
	//else it's a arith op
	System.out.printf("[Arith_Op: %s]\n", yytext());
}

int createId(){	
  Variables variable = new Variables();
  variable.setValue(yytext());

	if(scopes.get(scopeCount).getIsClosed()){
		//Add new method in the scope 0
    variable.setScope(0);
    variable.setSubscope(0);
    dictionary.add(varCount, variable);	
		++varCount;	
		
		//Create new scope
		++scopeCount;
    Scope scopeLocal = new Scope();
    scopeLocal.setIsClosed(false);
    scopeLocal.setIsLibrary(false);
    scopeLocal.setSubscopeCount(0);
    scopeLocal.setSubscope(0, false);

    scopes.add(scopeCount, scopeLocal);
		return varCount-1;
	}

	//create the new ID
  variable.setScope(scopeCount);
  variable.setSubscope(scopes.get(scopeCount).getSubscopeCount());
    
	dictionary.add(varCount, variable);	
	++varCount;	

	return varCount-1;
}

int checkID(){	
	if(isDeclaration && newSubcope){
		return createSubscope();
	}
	
  boolean isMain = yytext().equals("main"); 
  if(isMain){
		//scope 0 is closed
		scopes.get(0).setIsClosed(false);
		scopes.get(0).setIsLibrary(true);
		
		++scopeCount;
    Scope scope = new Scope();
    scope.setIsClosed(false);
    scope.setIsLibrary(false);
    scope.setSubscopeCount(0);
    scope.setSubscope(0, false);

    scopes.add(scopeCount, scope);

		return 0;
	}
	
	for(int i = varCount-1; i>=0; i--){
    boolean isEqual = yytext().equals(dictionary.get(i).getValue()); 
    
    if(isEqual) {
			int scopeID = dictionary.get(i).getScope();
			int subscopeID = dictionary.get(i).getSubscope();

			//the scope needs to be open or to be a library
			if(!scopes.get(scopeID).getIsClosed() || scopes.get(scopeID).getIsLibrary()){
			    if(subscopeID > 0){
					    //subscope needs to be open
			        if(!scopes.get(scopeID).getSubscope(subscopeID).getIsClosed()){
            			return i;
			        }
			    } else return i;
			}		
		}
	}
	return createId();
}


int createSubscope(){	
	braceCounterSubscope = braceCounter;
	scopes.get(scopeCount).setSubscopeCount(1);
  scopes.get(scopeCount).setSubscope(1, false);
	isThereSubscope = true;
	
  Variables variable = new Variables();
  variable.setValue(yytext());
  variable.setScope(scopeCount);
  variable.setSubscope(scopes.get(scopeCount).getSubscopeCount());
  dictionary.add(varCount, variable);

	++varCount;	
	return varCount-1;
}

void scopeInclude(){
	if(scopeCount == 0) {	
		//Scope methods creation
    Scope scopeLocal = new Scope();
    scopeLocal.setIsClosed(false);
    scopeLocal.setIsLibrary(false);
    scopeLocal.setSubscopeCount(0);
    scopeLocal.setSubscope(0, false);

    scopes.add(scopeCount, scopeLocal);

		System.out.println("Scope methods has been added");
		
    Variables variableLocal = new Variables();
    variableLocal.setScope(scopeCount);
    variableLocal.setSubscope(scopes.get(scopeCount).getSubscopeCount());
    variableLocal.setValue("main");

    dictionary.add(varCount, variableLocal);
    
		//ID main is created
		System.out.println("[ID " + varCount + ", Scope " +  dictionary.get(varCount).getScope() + ", Subscope " +  dictionary.get(varCount).getSubscope() + ",\"main\"]");
		++varCount;	
		++scopeCount;
	}

  boolean isStdioLib = yytext().equals("#include <stdio.h>");
	if(isStdioLib) {//It's equal
		
    //Scope stdio library creation
		System.out.printf("<stdio.h> library will be imported\n");

    Scope scopeLocal = new Scope();
    scopeLocal.setIsClosed(false);
    scopeLocal.setIsLibrary(false);
    scopeLocal.setSubscopeCount(0);

    scopes.add(scopeCount, scopeLocal);

		System.out.printf("<stdio.h> library scope has been added\n");
		
    Variables variableLocal = new Variables();
    variableLocal.setScope(scopeCount);
    variableLocal.setSubscope(scopes.get(scopeCount).getSubscopeCount());
    variableLocal.setValue("printf");

    dictionary.add(varCount, variableLocal);
		
    //ID printf is created
		System.out.println("[ID " + varCount + ", Scope " +  dictionary.get(varCount).getScope() + ", Subscope " +  dictionary.get(varCount).getSubscope() + ", \"printf\"] ");

		++varCount;	

    variableLocal.setScope(scopeCount);
    variableLocal.setSubscope(scopes.get(scopeCount).getSubscopeCount());
    variableLocal.setValue("scanf");

    dictionary.add(varCount, variableLocal);

		//ID scanf is created
    System.out.println("[ID " + varCount + ", Scope " +  dictionary.get(varCount).getScope() + ", Subscope " +  dictionary.get(varCount).getSubscope() + ", \"scanf\"] ");
		++varCount;	
		++scopeCount;
		System.out.println("<stdio.h> library scope has been imported");
	}

	
  boolean isConioLib = yytext().equals("#include <conio.h>");
	if(isConioLib) {//It's equal
		
    //Scope conio library creation
		System.out.println("<conio.h> library will be imported");
    
    Scope scopeLocal = new Scope();
    scopeLocal.setIsClosed(true);
    scopeLocal.setIsLibrary(true);
    scopeLocal.setSubscopeCount(0);
    scopeLocal.setSubscope(0, true);

    scopes.add(scopeCount, scopeLocal);
		
    System.out.println("<conio.h> library scope has been added");

    Variables variableLocal = new Variables();
    variableLocal.setScope(scopeCount);
    variableLocal.setSubscope(scopes.get(scopeCount).getSubscopeCount());
    variableLocal.setValue("clrscr");
    
    dictionary.add(varCount, variableLocal);
		
    //ID clrscr is created
    System.out.println("[ID " + varCount + ", Scope " +  dictionary.get(varCount).getScope() + ", Subscope " +  dictionary.get(varCount).getSubscope() + ", \"clrscr\"] ");
		++varCount;	
		
    variableLocal.setScope(scopeCount);
    variableLocal.setSubscope(scopes.get(scopeCount).getSubscopeCount());
    variableLocal.setValue("getch");
    
    dictionary.add(varCount, variableLocal);
		
    //ID getch is created
    System.out.println("[ID " + varCount + ", Scope " +  dictionary.get(varCount).getScope() + ", Subscope " +  dictionary.get(varCount).getSubscope() + ", \"getch\"] ");
    
		++varCount;	
		System.out.println("<conio.h> library scope has been imported");
	}
}

%}

%%
/* LEXICAL RULES */
{ADDRESS}              {System.out.println("[Address, &]");}

{ARITH_OP}             {System.out.printf("[Arith_Op: %s]\n", yytext());}

{COMMA}                {System.out.println("[Comma, ,]");}

{DIGIT}+               {System.out.printf("[Digit, %d]\n", Integer.parseInt(yytext()));}

{DECREMENT_OP}         {System.out.println("[Dec_Op, --]");}

{EQUAL}                {System.out.println("[Equal, =]");}

{FLOAT}                {System.out.printf("[Float, %.1f]\n", Float.parseFloat(yytext()));}

{ID} {
	int id = checkID();
  newSubcope = false;
	isDeclaration = false;
  System.out.println("[ID " + id + ", Scope " +  dictionary.get(id).getScope() + ", Subscope " +  dictionary.get(id).getSubscope() + ", "+ yytext() + "]");
}

{INCREMENT_OP}         {System.out.println("[Inc_Op, ++]");}

{INCLUDE}              {scopeInclude();}

{LOGIC_OP}             {System.out.printf("[Logic_Op, %s]\n", yytext());}

{L_PAREN}              {System.out.println("[L_Paren, (]");}

{L_BRACKET}            {System.out.println("[L_Bracket, []");}

{L_BRACE} {
	++braceCounter;
	System.out.println("[L_Brace, {]");
}

{R_PAREN}              {System.out.println("[R_Paren, )]");}

{R_BRACKET}            {System.out.println("[R_Bracket, ]]");}

{R_BRACE} {
	--braceCounter;
	checkScope();
	System.out.println("[R_Brace, }]");
}

{RESERVED_WORD}	       {System.out.printf("[reserved_word, %s]\n", yytext());}

{RESERVED_WORD_DECLARATION}	{
	isDeclaration = true;
	System.out.printf("[reserved_word, %s]\n", yytext());
}

{RESERVED_WORD_SCOPE} {
	newSubcope = true;
	System.out.printf("[reserved_word, %s]\n", yytext());
}

{RESERVED_WORD_POINTER} {
	checkPointer();
}

{RELATIONAL_OP}        {System.out.printf("[Relational_Op, %s]\n", yytext());}

{SEMICOLON}            {System.out.println("[Semicolon, ;]");}

{STRING}               {System.out.printf("[String_literal, %s]\n", yytext());}

{SINGLE_LINE_COMMENT} | {BLOCK_COMMENT} | [ "\\t"]+ | "\\n" | " \\n" | "\\t" {}

. {System.out.printf("NOT RECOGNIZED: \n" + "<" + yytext()+">");}
