Page({
  data: {
    inputText: '',
    scrollToView: '',
    messages: [
      {
        id: 'msg_1',
        type: 'incoming',
        text: '嗨！方案你看了吗？觉得怎么样？',
        time: '10:30'
      },
      {
        id: 'msg_2',
        type: 'outgoing',
        text: '看了，整体框架很棒！我已经根据你的建议改了一版样式。',
        time: '10:32'
      },
      {
        id: 'msg_3',
        type: 'incoming',
        text: '太好了，那我们下午两点开个简会过一下细节吧。',
        time: '10:33'
      }
    ]
  },

  onLoad() {
    this.scrollToBottom();
  },

  // 监听输入
  onInput(e) {
    this.setData({
      inputText: e.detail.value
    });
  },

  // 发送消息
  sendMessage() {
    const text = this.data.inputText.trim();
    if (!text) return;

    // 当前时间 (HH:MM)
    const now = new Date();
    const time = `${now.getHours().toString().padStart(2, '0')}:${now.getMinutes().toString().padStart(2, '0')}`;

    const newMsg = {
      id: `msg_${Date.now()}`,
      type: 'outgoing',
      text: text,
      time: time
    };

    this.setData({
      messages: [...this.data.messages, newMsg],
      inputText: ''
    }, () => {
      this.scrollToBottom();
    });
  },

  // 滚动到底部
  scrollToBottom() {
    this.setData({
      scrollToView: 'bottom-anchor'
    });
  }
});