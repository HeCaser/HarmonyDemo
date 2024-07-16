import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { relationalStore } from '@kit.ArkData'; // 导入模块
import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI';


export class DbUtil {
  private static store?: relationalStore.RdbStore

  static init(ctx: Context) {
    const STORE_CONFIG: relationalStore.StoreConfig = {
      name: 'RdbTest.db', // 数据库文件名
      securityLevel: relationalStore.SecurityLevel.S1, // 数据库安全级别
      encrypt: false, // 可选参数，指定数据库是否加密，默认不加密
      customDir: 'fund/user' // 可选参数，数据库自定义路径。数据库将在如下的目录结构中被创建：context.databaseDir + '/rdb/' + customDir，其中context.databaseDir是应用沙箱对应的路径，'/rdb/'表示创建的是关系型数据库，customDir表示自定义的路径。当此参数不填时，默认在本应用沙箱目录下创建RdbStore实例。
    };
    // 判断数据库版本，如果不匹配则需进行升降级操作
    // 假设当前数据库版本为3，表结构：EMPLOYEE (NAME, AGE, SALARY, CODES, IDENTITY)
    const SQL_CREATE_TABLE = 'CREATE TABLE IF NOT EXISTS EMPLOYEE (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT NOT NULL, AGE INTEGER, SALARY REAL, CODES BLOB, IDENTITY UNLIMITED INT)'; // 建表Sql语句, IDENTITY为bigint类型，sql中指定类型为UNLIMITED INT

    relationalStore.getRdbStore(ctx, STORE_CONFIG, (err, store) => {
      if (err) {
        console.error(`Failed to get RdbStore. Code:${err.code}, message:${err.message}`);
        return;
      }

      if (store) {
        DbUtil.store = store
        console.info('Succeeded in getting RdbStore.');
      } else {
        console.error(`Failed store is null`);
      }

      // 当数据库创建时，数据库默认版本为0
      if (store.version === 0) {
        store.executeSql(SQL_CREATE_TABLE); // 创建数据表
        // 设置数据库的版本，入参为大于0的整数
        store.version = 1;
      }

      if (store.version === 1) {
        console.log("hepan version =1")

      }
    });

  }

  static insert() {
    const valueBucket1: relationalStore.ValuesBucket = {
      'NAME': 'hepan',
      'AGE': 32,
      'SALARY': 300000,
      'CODES': 9,
    };

    if (DbUtil.store !== undefined) {
      DbUtil.store.insert('EMPLOYEE', valueBucket1, (err: BusinessError, rowId: number) => {
        if (err) {
          console.error(`Failed to insert data. Code:${err.code}, message:${err.message}`);
          return;
        }
        console.info(`Succeeded in inserting data. rowId:${rowId}`);
      })
    }
  }

  static query() {
    let predicates2 = new relationalStore.RdbPredicates('EMPLOYEE');
    predicates2.equalTo('NAME', 'hepan');

    if (DbUtil.store !== undefined) {
      DbUtil.store.query(predicates2, ['ID', 'NAME', 'AGE', 'SALARY', 'IDENTITY'], (err: BusinessError, resultSet) => {
        if (err) {
          console.error(`Failed to query data. Code:${err.code}, message:${err.message}`);
          return;
        }
        console.info(`ResultSet column names: ${resultSet.columnNames}, column count: ${resultSet.columnCount}`);
        // resultSet是一个数据集合的游标，默认指向第-1个记录，有效的数据从0开始。
        while (resultSet.goToNextRow()) {
          const id = resultSet.getLong(resultSet.getColumnIndex('ID'));
          const name = resultSet.getString(resultSet.getColumnIndex('NAME'));
          const age = resultSet.getLong(resultSet.getColumnIndex('AGE'));
          const salary = resultSet.getDouble(resultSet.getColumnIndex('SALARY'));
          console.info(`id=${id}, name=${name}, age=${age}, salary=${salary}, `);
        }
        // 释放数据集的内存
        resultSet.close();
      })
    }
  }
}