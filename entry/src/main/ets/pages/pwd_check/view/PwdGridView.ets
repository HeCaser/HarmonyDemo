@Component
export struct PwdGridView {
  @Prop pwd: string = ''

  build() {
    Row() {
      Item({ value: this.pwd.charAt(0), index: 0 })
      Item({ value: this.pwd.charAt(1), index: 1 })
      Item({ value: this.pwd.charAt(2), index: 2 })
      Item({ value: this.pwd.charAt(3), index: 3 })
      Item({ value: this.pwd.charAt(4), index: 4 })

    }.width('100%').height('100%').justifyContent(FlexAlign.SpaceAround)
  }
}

@Component
struct Item {
  lastIndex: number = 4
  value: string = ''
  index: number = 0

  build() {
    Text(this.value)
      .layoutWeight(1)
      .textAlign(TextAlign.Center)
      .height('100%')
      .borderWidth({
        top: 1,
        bottom: 1,
        right: this.index == this.lastIndex ? 1 : 0,
        left: 1
      })
      .borderColor('#ddd')
  }
}