import { PwdGridView } from './pwd_check/view/PwdGridView';
import { KeyboardView } from './pwd_check/view/KeyboardView';
import { PwdCheckPage } from './pwd_check/PwdCheckPage';
import { PropDemo } from './basic/PropDemo';
import { GesturePwdCheck } from './pwd_check/GestureCheckPage';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State pwd: string = '*-03456';

  test() {

  }

  // onBackPress(): boolean | void {
  //   return true
  // }

  build() {
    Column() {

      Button("Test").onClick(() => {
        this.test()
      }).width(100)

      GesturePwdCheck().layoutWeight(1)

    }.width('100%').height('100%')
  }
}

