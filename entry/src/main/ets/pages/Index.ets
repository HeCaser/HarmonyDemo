import { PwdGridView } from './pwd_check/view/PwdGridView';
import { KeyboardView } from './pwd_check/view/KeyboardView';
import { PwdCheckPage } from './pwd_check/PwdCheckPage';
import { PropDemo } from './basic/PropDemo';
import { GesturePwdCheck } from './pwd_check/GestureCheckPage';
import { RouterURLTest } from './basic/RouterURLTest';
import { GesturePwdSketch } from './pwd_check/view/GesturePwdSketch';
import { GestureView } from './pwd_check/view/GestureView';
import { SimpleTitleView } from './pwd_check/view/SimpleTitleView';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State pwd: string = '048';

  test() {
    if (this.pwd.length >= 8) {
      this.pwd = ""

    } else {
     this.pwd =  this.pwd + `${this.pwd.length}`
    }
  }

  // onBackPress(): boolean | void {
  //   return true
  // }

  build() {
    Column() {
      SimpleTitleView({
        title:'设置手势密码',
        right_title:"重置",
        onBackClick:()=>{
          router.back()
        },
        onRightTitleClick:()=>{
          // this.resetState()
        }
      })
      Button("Test").onClick(() => {
        this.test()
      }).width(100)

    GestureView({
      gesture_pwd:this.pwd
    }).layoutWeight(1)
      // RouterURLTest().layoutWeight(1)

    }.width('100%').height('100%')
  }
}

