import { DialogDemo } from './dialog/DialogDemo';

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
        this.showDialog()
      })
      DialogDemo().backgroundColor('red')
    }.width(100)

  }

  showDialog() {

  }

}

