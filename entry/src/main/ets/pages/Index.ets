import { PwdGridView } from './pwd_check/view/PwdGridView';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State pwd: string = '103456';

  build() {
    Column() {
     PwdGridView({pwd:this.pwd}).margin({left:12,right:12}).height(40)
    }.width('100%')
  }

}

