import { DbUtil } from '../util/DbUtil'

@Component
export struct DbStore {


  build() {

    Column(){
      Button("插入").onClick(()=>{
        DbUtil.insert()
      })
      Button("读取").onClick(()=>{
        DbUtil.query()
      })
    }
  }
}