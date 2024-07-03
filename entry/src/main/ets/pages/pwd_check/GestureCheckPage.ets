import { GestureView } from './view/GestureView';

@Component
export struct GesturePwdCheck {
  @State message: string = 'Hello World';
  @State pwd: string = ''

  aboutToAppear(): void {
    // setTimeout(()=>{
    //     this.pwd ='012345'
    // },1000)
  }

  build() {
    Row() {
      GestureView({
        gesture_pwd: this.pwd, onCanvasReady: () => {
          this.pwd = '012'
        },
        onGestureEnd:(pwd:string)=>{
          console.log("hepan 收到密码 "+pwd)
        }
      }).width('100%')
    }
  }
}
