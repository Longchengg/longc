--
-- Author: zyuq
-- Date: 2015-11-17 11:46:29
module("ModifyData",package.seeall)

chapterNumber = 1
--设置关卡数
function setChapterNumber(num)
	chapterNumber = num 
end
--得到关卡数
function getChapterNumber()
	return chapterNumber
end
--写入沙盒路径
function writeToDoc(str)
	local docpath = cc.FileUtils:getInstance():getWritablePath().."data.txt"
	local f = assert(io.open(docpath,'w'))
	f:write(str)
	f:close()
end
--从沙盒路径下读出
function readFromDoc()
	local docpath = cc.FileUtils:getInstance():getWritablePath().."data.txt"
	local str = cc.FileUtils:getInstance():getStringFromFile(docpath)
	return str
end