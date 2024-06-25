import { DialogDemo } from './dialog/DialogDemo';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    Column() {
      // PwdCheckComponent(){
      //
      // }

      Button("Test").onClick(() => {
        // this.showDialog()

        router.pushUrl({
          url: "pages/router/Page2", params: {
            callBack: (type: number, dataString: string) => {
              console.log("hepan 回调 "+type)
            },
            test: '00'
          }
        })
      })
      DialogDemo()
    }.width(100)

  }

  showDialog() {

  }

  onAppear(event: () => void): CommonAttribute {
    return super.onAppear(event)
  }
}

