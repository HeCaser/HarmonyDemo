@Entry
@Component
export struct DialogDemo {
  @State message: string = 'Hello World';
  fullDialogController = new CustomDialogController({
    builder: CustomDialogFull(),
    cancel: () => {
      console.log("hepan 外部取消")
    },
    // 定义为 true , 弹框可以展示为全屏
    customStyle: true
  })

  build() {
    Row() {
      Button("点击展示全局弹框").onClick(() => {
        this.fullDialogController.open()
      })
    }
  }
}

@CustomDialog
struct CustomDialogFull {
  controller?: CustomDialogController

  build() {
    Column() {
      Text('我是弹窗,我是弹窗,我是弹窗,我是弹窗,我是弹窗,我是弹窗')
        .fontSize(30).onClick(() => {
      })

    }.width('100%').height('100%').backgroundColor('gray')
  }
}

