extends Control

@onready var input = $InputTextEdit          # 上方文本框
@onready var output = $OutputTextEdit         # 下方文本框
@onready var button = $OutputButton           # 输出按钮
@onready var copy = $copy

func _ready():
	get_window().move_to_center()
	button.pressed.connect(main)
	copy.pressed.connect(_copy)

func _copy():
	var copy0 = output.text
	DisplayServer.clipboard_set(copy0)
	output.text = "已复制成功喵"
	print("成功喵")

func is_punctuation(test: String) -> int:
	# 只处理单个字符，如果不是单个字符则返回0
	if test.length() != 1:
		return 0
	
	var ch = test[0]
	# 定义常见标点符号集合（包含中英文）
	var punctuation_chars = "。，、；：？！…—～·《》〈〉“”‘’（）【】〔〕
	［］｛｝！？，．：；\"'()[]{}<>.,!?;:-^"
	# 判断字符是否在集合中
	return 1 if ch in punctuation_chars else 0

func main():
	var text = input.text
	var is_more = 0
	var a = '喵'
	var result = ''
	var len = text.length()
	
	for i in len:
		if is_punctuation(text[i]) or text[i]=='\n':
			if is_more == 0:
				result+= a + text[i]
				is_more = 1
			else:
				result+= text[i]
		else:
			if text[i]==' ':
				result+=text[i]
			else:
				is_more = 0
				result+=text[i]
		if i == len - 1:
			if is_punctuation(text[i]) or text[i]=='n':
				continue
			else:
				result+=a
	output.text = result
