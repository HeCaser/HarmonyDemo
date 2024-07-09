import { GestureView } from './view/GestureView';

@Component
export struct GesturePwdCheck {
  @State message: string = 'Hello World';
  @State pwd: string = ''
  @State normalHint: string = '请绘制解锁图案'
  @State errorHint: string = ''
  @State showErrorView: boolean = false

  // 手势密码, 用于清空 GestureView 状态

  private onGesturePwdFinish(pwd: string) {
    console.log(`hepan pwd 是否是 true ${!pwd}  长度 = ${pwd.length}`)
    if (!pwd || pwd.length < 4) {
      this.errorHint = '至少链接4个点，请重新绘制'

      // setTimeout(()=>{
      //
      // },300)
      this.showErrorView = true
      this.delayClearPwd()
    } else {

      this.errorHint = '满足条件'
      this.delayClearPwd()
    }
  }

  aboutToAppear(): void {
    // setTimeout(()=>{
    //     this.pwd ='012345'
    // },1000)
  }

  private delayClearPwd() {
    setTimeout(() => {
      this.pwd = ''
      this.showErrorView = false
    }, 1400)

  }

  build() {
    Column() {
      GestureSketch()
      Text(this.normalHint)
        .margin({ top: 20 })

      Text(`pwd = ${this.pwd}`)
      Text(this.errorHint).margin({ top: 20 })
        .fontColor("#ff7700")

      Button('清空').onClick(() => {
        // this.pwd=''
        if (this.pwd.length == 5) {
          this.pwd = ''

        } else {
          this.pwd = this.pwd + this.pwd.length
        }
      })
      Row() {

        GestureView({
          gesture_pwd: this.pwd,
          show_error_pattern: this.showErrorView,
          onCanvasReady: () => {
          },
          onGestureEnd: (pwd: string) => {
            this.pwd = pwd
            this.onGesturePwdFinish(pwd)
            console.log("hepan 收到密码 " + pwd)
          }
        }).width('100%')
      }
    }
  }
}

@Component
struct GestureSketch {
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  build() {
    Column() {
      Column() {
        Canvas(this.context).width('100%').height('100%').onReady(() => {

        })

      }.width(120)
      .height(120)
    }
  }
}