---
title: SQLiteProgranm
layout: page
tags: ProgramDesign
categories: ProgramDesign
date: 2020-02-18 22:18
---
### __这个项目的坑太多了不知道怎么说__
```c++
#include <stdio.h>
----------------------------
#include "sqlite3.h"
1.库的引用要自己编译，添加，最简单的方法
就是这样直接拉到项目里。
----------------------------
#include <stdlib.h>
------------------------------------------------------------------------------
static int callback(void* NotUsed, int argc, char** argv, char** azColName) {
    int i;
    for (i = 0; i < argc; i++) {
        printf("%s = %s\n", azColName[i], argv[i] ? argv[i] : "NULL");
    }
    printf("\n");
    return 0;
}
这个函数到底是干什么的？
------------------------------------------------------------------------------
int main(int argc, char* argv[])
{
    sqlite3* db;//sqlite3 类型数据库
    char* zErrMsg = 0; //字串 0
    int rc;
    const char* sql;
-----------------------------------------------------------------------------
    rc = sqlite3_open("test.db", &db); //传值给db<<open.database. 
    //对于sqlite3直接打开文件读写参数（文件，sqlite3类）
    //close(sqlite3类)
    //return->0通过
-----------------------------------------------------------------------------
    if (rc) {//0 -》 true
-----------------------------------------------------------------------------
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        exit(0);
        //首先是上面这个函数：#include<cstdio> 干啥用的呢（文件流，传入文件流的文本，自定义）
        //stderr这是个啥呢？¹
-----------------------------------------------------------------------------        
    }
    else {
        fprintf(stderr, "Opened database successfully\n");
    }
    /*sql statement*/
    sql = "CREATE TABLE COMPANY("  \
        "ID INT PRIMARY KEY     NOT NULL," \
        "NAME           TEXT    NOT NULL," \
        "AGE            INT     NOT NULL," \
        "ADDRESS        CHAR(50)," \
        "SALARY         REAL );";
    /*exec sql statement*/
    rc = sqlite3_exec(db, sql, callback, 0, &zErrMsg);
    if (rc != SQLITE_OK) {
        fprintf(stderr, "SQL error: %s\n", zErrMsg);
        sqlite3_free(zErrMsg);
    }
    else {
        fprintf(stdout, "Table created successfully\n");
    }
    /* Create SQL statement */
    sql = "INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY) "  \
        "VALUES (1, 'Paul', 32, 'California', 20000.00 ); " \
        "INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY) "  \
        "VALUES (2, 'Allen', 25, 'Texas', 15000.00 ); "     \
        "INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY)" \
        "VALUES (3, 'Teddy', 23, 'Norway', 20000.00 );" \
        "INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY)" \
        "VALUES (4, 'Mark', 25, 'Rich-Mond ', 65000.00 );";
    /* Execute SQL statement */
    rc = sqlite3_exec(db, sql, callback, 0, &zErrMsg);
    if (rc != SQLITE_OK) {
        fprintf(stderr, "SQL error: %s\n", zErrMsg);
        sqlite3_free(zErrMsg);
    }
    else {
        fprintf(stdout, "Records created successfully\n");
    }
    sqlite3_close(db);
    return 0;
}
```
<article>
1.[2020-02-18-stderrFunction]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="/posts/programdesign/stderrFunction">programdesign/stderrFunction</a>
</article>