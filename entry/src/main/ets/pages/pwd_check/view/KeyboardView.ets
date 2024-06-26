export enum KeyBoardType {
  NUMBER = "NUMBER",
  DELETE = "DELETE",
}

@Component
export struct KeyboardView {
  @State numbers: string[] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
  onItemClick?: (type: KeyBoardType, value: string) => void = undefined

  invokeItemClick(type: KeyBoardType, value: string) {
    if (this.onItemClick) {
      this.onItemClick(type, value)
    }
  }

  build() {
    Column() {

      // 1-9
      Grid() {
        ForEach(this.numbers, (item: string, index: number) => {
          GridItem() {
            Text(item)
              .height('100%')
              .width('100%')
              .textAlign(TextAlign.Center)
              .fontWeight(500)
              .borderWidth({
                top: 1,
                bottom: 0,
                right: (index + 1) % 3 == 0 ? 0 : 1,
                left: 0
              })
              .borderColor('#ddd')
          }.onClick(() => {
            this.invokeItemClick(KeyBoardType.NUMBER, item)
          })

        })

      }.columnsTemplate('1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr')
      .width('100%')
      .height('75%')

      // 底部三个
      Grid() {
        GridItem() {
        }.backgroundColor('#ddd').width('100%').height('100%')

        GridItem() {
          Text("0")
            .height('100%')
            .width('100%')
            .textAlign(TextAlign.Center)
            .fontWeight(500)
            .borderWidth({
              top: 1,
              bottom: 1,
              right: 1
            })
            .borderColor('#ddd')
        }.onClick(() => {
          this.invokeItemClick(KeyBoardType.NUMBER, "0")
        })

        GridItem() {
          Image($r('app.media.pay_keyboard_delete')).width(30)
        }.backgroundColor('#ddd').width('100%').height('100%')
        .onClick(() => {
          this.invokeItemClick(KeyBoardType.DELETE, "")
        })
      }.columnsTemplate('1fr 1fr 1fr')
      .rowsTemplate('1fr')
      .width('100%')
      .height('25%')

    }.width('100%')
    .height('100%')

  }
}