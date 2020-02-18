---
title: RecodeContainWithText
layout: page
tags: ProgramDesign
categories: ProgramDesign
date: 2020-02-18 15:47
---
```HTML
<article>
    <h1>怎样把文本文件当作数据库</h1>
        <p class="interview">
            如果你有COC（TRPG）的表，生成一个txt文档，或许它能够成为简单的数据库了（虽然只有一行）。<!--灰色小字部分-->
        </p>
        <p>
		    <span class="texttitle">1.将它存储为一个vector（长度不确定）根据位置获取数据。</span>
		    <pre>	
	将文本初始化，符号空格该删的删。
	新建一个文本文档生成一个总的关系,也就是表头的顺序，然后导出覆盖。当要读取文件的时候，就可以先读取表头文件的关系。
优点：当数量少时，方便人为查阅。更改一个人物卡不会对其他人物卡造成影响。
缺点：会生成一大堆文件。
			</pre>
			<span class="texttitle">2.将它存储为一个vector（长度确定）根据位置获取数据。</span>>
			<pre>
	将文本初始化，符号空格该删的删，需要的话要补NULL。
	新建一个文本文档创建一个总的关系,也就是表头的顺序。当要读取文件的时候，就可以先读取表头文件的关系。
优点：便于读取识别。
缺点：人物卡数量少时，查找的时候不方便（有许多NULL,而且挺长），不能进行个人的格式更改，如果要改全都要动。
			</pre>
		</p>
</article>
```

# 以上问题已经解决找到了一个最合适的静态连接的数据库sqlite

### Q1：这东西怎么安装？
> 和gcc一样简单易懂，就是要dll和axp和tool放在一起。附上[官网](https://www.sqlite.org/index.html)。

### Q2:安装完打开是红字怎么办？
> 这个东西是需要文件支持的，直接打开会访问内存。使用
```command
$sqlite3 filename
```

### Q3:卧槽，SQL忘了怎么办？
> 附上 [链接](https://www.runoob.com/sqlite/sqlite-tutorial.html)。

### Q4:他不显示表头怎么办？
> ".header on" 启用表头
> ".mode column" 使用列模式
来自Sacrednes [ssqlite3查询：显示表头 与 对齐](https://blog.csdn.net/Sacredness/article/details/81953315)。

### Q5:我怎么在编程语言中使用？
> 详细[介绍](https://www.runoob.com/sqlite/sqlite-c-cpp.html)。
```c++
#include <stdio.h>
#include "sqlite3.h"
#include <stdlib.h>
static int callback(void* NotUsed, int argc, char** argv, char** azColName) {
    int i;
    for (i = 0; i < argc; i++) {
        printf("%s = %s\n", azColName[i], argv[i] ? argv[i] : "NULL");
    }
    printf("\n");
    return 0;
}
int main(int argc, char* argv[])
{
    sqlite3* db;//sqlite3 类型数据库
    char* zErrMsg = 0; //字串 0
    int rc;
    const char* sql;
    rc = sqlite3_open("test.db", &db); //传值给db<<open.database. 
    if (rc) {//0 -》 true
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        exit(0);
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
自己的[说明](/posts/programdesign/SQLiteFirstProgranm)

### Q6:这东西除了sql语句，全局设置在哪？
>
```Linux
.archive ...             Manage SQL archives
.auth ON|OFF             Show authorizer callbacks
.backup ?DB? FILE        Backup DB (default "main") to FILE
.bail on|off             Stop after hitting an error.  Default OFF
.binary on|off           Turn binary output on or off.  Default OFF
.cd DIRECTORY            Change the working directory to DIRECTORY
.changes on|off          Show number of rows changed by SQL
.check GLOB              Fail if output since .testcase does not match
.clone NEWDB             Clone data into NEWDB from the existing database
.databases               List names and files of attached databases
.dbconfig ?op? ?val?     List or change sqlite3_db_config() options
.dbinfo ?DB?             Show status information about the database
.dump ?TABLE? ...        Render all database content as SQL
.echo on|off             Turn command echo on or off
.eqp on|off|full|...     Enable or disable automatic EXPLAIN QUERY PLAN
.excel                   Display the output of next command in spreadsheet
.exit ?CODE?             Exit this program with return-code CODE
.expert                  EXPERIMENTAL. Suggest indexes for queries
.explain ?on|off|auto?   Change the EXPLAIN formatting mode.  Default: auto
.filectrl CMD ...        Run various sqlite3_file_control() operations
.fullschema ?--indent?   Show schema and the content of sqlite_stat tables
.headers on|off          Turn display of headers on or off
.help ?-all? ?PATTERN?   Show help text for PATTERN
.import FILE TABLE       Import data from FILE into TABLE
.imposter INDEX TABLE    Create imposter table TABLE on index INDEX
.indexes ?TABLE?         Show names of indexes
.limit ?LIMIT? ?VAL?     Display or change the value of an SQLITE_LIMIT
.lint OPTIONS            Report potential schema issues.
.load FILE ?ENTRY?       Load an extension library
.log FILE|off            Turn logging on or off.  FILE can be stderr/stdout
.mode MODE ?TABLE?       Set output mode
.nullvalue STRING        Use STRING in place of NULL values
.once (-e|-x|FILE)       Output for the next SQL command only to FILE
.open ?OPTIONS? ?FILE?   Close existing database and reopen FILE
.output ?FILE?           Send output to FILE or stdout if FILE is omitted
.parameter CMD ...       Manage SQL parameter bindings
.print STRING...         Print literal STRING
.progress N              Invoke progress handler after every N opcodes
.prompt MAIN CONTINUE    Replace the standard prompts
.quit                    Exit this program
.read FILE               Read input from FILE
.recover                 Recover as much data as possible from corrupt db.
.restore ?DB? FILE       Restore content of DB (default "main") from FILE
.save FILE               Write in-memory database into FILE
.scanstats on|off        Turn sqlite3_stmt_scanstatus() metrics on or off
.schema ?PATTERN?        Show the CREATE statements matching PATTERN
.selftest ?OPTIONS?      Run tests defined in the SELFTEST table
.separator COL ?ROW?     Change the column and row separators
.sha3sum ...             Compute a SHA3 hash of database content
.shell CMD ARGS...       Run CMD ARGS... in a system shell
.show                    Show the current values for various settings
.stats ?on|off?          Show stats or turn stats on or off
.system CMD ARGS...      Run CMD ARGS... in a system shell
.tables ?TABLE?          List names of tables matching LIKE pattern TABLE
.testcase NAME           Begin redirecting output to 'testcase-out.txt'
.testctrl CMD ...        Run various sqlite3_test_control() operations
.timeout MS              Try opening locked tables for MS milliseconds
.timer on|off            Turn SQL timer on or off
.trace ?OPTIONS?         Output each SQL statement as it is run
.vfsinfo ?AUX?           Information about the top-level VFS
.vfslist                 List all available VFSes
.vfsname ?AUX?           Print the name of the VFS stack
.width NUM1 NUM2 ...     Set column widths for "column" mode
```

