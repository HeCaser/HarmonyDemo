import { GestureView } from './view/GestureView';

@Component
export struct GesturePwdCheck {
  @State message: string = 'Hello World';

  build() {
    Row() {
      GestureView().width('100%')
    }
  }
}
