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


      ForEach([0, 1, 2, 3, 4], (item: number) => {
        Line().backgroundColor('#ddd').width('100%').height(1).position({ y: `${25 * item}%` })
        if (item == 1 || item == 2) {
          Line().backgroundColor('#ddd').height('100%').width(1).position({ x: `${33.333 * item}%` })
        }
      })


      // 1-9
      Grid() {
        ForEach(this.numbers, (item: string, index: number) => {
          GridItem() {
            Text(item)
              .height('100%')
              .width('100%')
              .textAlign(TextAlign.Center)
              .fontWeight(500)
              .fontSize(18)
              .onClick(() => {
                this.invokeItemClick(KeyBoardType.NUMBER, item)
              })
              .clickEffect({
                level: ClickEffectLevel.HEAVY,
                scale: 0.4
              })
          }

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
            .fontSize(18)
            .onClick(() => {
              this.invokeItemClick(KeyBoardType.NUMBER, "0")
            })
            .clickEffect({
              level: ClickEffectLevel.HEAVY,
              scale: 0.4
            })

        }

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