@Component
export struct PwdGridView {
  @Prop pwd: string = ''

  build() {
    Row() {
      ForEach([0, 1, 2, 3, 4, 5], (item: number, index) => {
        Item({ value: this.pwd.charAt(index), index })
      })
    }.width('100%').height('100%').justifyContent(FlexAlign.SpaceAround)
  }
}

@Component
struct Item {
  @Prop value: string = ''
  index: number = 0
  lastIndex: number = 5
  borderW: number = 1

  build() {
    Text(this.value)
      .layoutWeight(1)
      .textAlign(TextAlign.Center)
      .height('100%')
      .fontWeight(500)
      .borderWidth({
        top: this.borderW,
        bottom: this.borderW,
        right: this.index == this.lastIndex ? this.borderW : 0,
        left: this.borderW
      })
      .borderColor('#ddd')
  }
}