import { KeyBoardType, KeyboardView } from './view/KeyboardView';
import { router } from '@kit.ArkUI';
import { PwdGridView } from './view/PwdGridView';

/**
 * 密码验证页面
 */
@Entry
@Component
export struct PwdCheckPage {
  @State message: string = 'Hello World';
  @State showPwd: string = ''
  inputPwd: string = ''

  onPwdInput(type: KeyBoardType, value: string) {
    let length = this.inputPwd.length
    if (type == KeyBoardType.NUMBER) {
      if (length >= 6) {
        return
      }

      this.inputPwd = this.inputPwd + value
      this.showPwd = this.showPwd + "*"
    } else {
      if (length > 0) {
        this.inputPwd = this.inputPwd.slice(0, length - 1)
        this.showPwd = this.showPwd.slice(0, length - 1)
      }
    }

  }

  build() {
    Column() {
      Row() {
        Image($r('app.media.icon_l_close_day'))
          .position({ x: 10, y: 0 })
          .width(24)
          .height(24)
          .onClick(() => {
            router.back()
          })
        Text('交易密码解锁')
          .fontSize(20)
          .alignSelf(ItemAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)

      Column() {
        Text('验证基金交易密码')
          .fontSize(22)
          .textAlign(TextAlign.Center)
          .fontWeight(FontWeight.Bold)
          .width('100%')

        Text('请输入交易密码，以验证身份')
          .fontSize(16)
          .textAlign(TextAlign.Center)
          .width('100%').margin({ top: 12 })

        PwdGridView({ pwd: this.showPwd }).height(46).margin({ top: 30 })

        Text('台在线时长到期，需要您手动解锁查看资产，具体时长可在设置页更改')
          .fontSize(14)
          .textAlign(TextAlign.Center)
          .width('100%').margin({ top: 10 })


      }.position({ y: 90 }).margin({ left: 12, right: 12 })


      KeyboardView({
        onItemClick: (type, value) => {
          this.onPwdInput(type, value)
        }
      }).height(190)
    }.justifyContent(FlexAlign.SpaceBetween).height('100%')

  }
}
