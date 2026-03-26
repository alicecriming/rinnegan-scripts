local var_0_2 = string.char
local var_0_3 = string.byte
local var_0_4 = string.sub
local var_0_5 = (bit32 or bit).bxor
local var_0_6 = table.concat
local var_0_7 = table.insert

local function var_0_8(arg_8_0, arg_8_1)
	local var_8_0 = 0
	local var_8_1
	local var_8_2

	while true do
		if var_8_0 == 1 then
			while true do
				local var_8_3 = 0

				while true do
					if var_8_3 == 0 then
						if var_8_1 == 1 then
							return var_0_6(var_8_2)
						end

						if var_8_1 == 0 then
							local var_8_4 = 0

							while true do
								if var_8_4 == 0 then
									var_8_2 = {}

									for iter_8_0 = 1, #arg_8_0 do
										var_0_7(var_8_2, var_0_2(var_0_5(var_0_3(var_0_4(arg_8_0, iter_8_0, iter_8_0 + 1)), var_0_3(var_0_4(arg_8_1, 1 + iter_8_0 % #arg_8_1, 1 + iter_8_0 % #arg_8_1 + 1))) % 256))
									end

									var_8_4 = 1
								end

								if var_8_4 == 1 then
									var_8_1 = 1

									break
								end
							end

						end

						break
					end
				end
			end

			break
		end

		if var_8_0 == 0 then
			local var_8_5 = 0

			while true do
				if var_8_5 == 1 then
					var_8_0 = 1

					break
				end

				if var_8_5 == 0 then
					var_8_1 = 0
					var_8_2 = nil
					var_8_5 = 1
				end
			end
		end
	end
end

local var_0_11 = require(var_0_8("L\xA2\xC4", "\xC4.˰\x12O\xA3-"))
local var_0_21 = tostring

local var_27_6 = require(var_0_8("\xB2\x1C\x0F\xAEJ\xBA", "P\xC4yl\xDA%\xC8\xD5"))
								local var_27_7 = require(var_0_8("\x06u\v", "\xEA`\x13b\x1F+n"))
								local var_27_8 = require(var_0_8("\x01\x1E_¿w\x85\x15\x1A\x1D´f\x8E\b\x1BWÓw\x93\x16\x13]θa", "\xEBf\x7F2\xA7\xCC\x12"))
								local var_27_9 = {}

								local function var_27_10(arg_28_0, arg_28_1, arg_28_2)
									return math.min(math.max(arg_28_0, arg_28_1), arg_28_2)
								end

								function class(arg_29_0)
									return function(arg_30_0)
										if not arg_30_0 then
											return classes[arg_29_0]
										end

										arg_30_0.__index, arg_30_0.__classname = arg_30_0, arg_29_0

										if arg_30_0.call then
											arg_30_0.__call = arg_30_0.call
										end

										setmetatable(arg_30_0, arg_30_0)

										var_27_9[arg_29_0], _G[arg_29_0] = arg_30_0, arg_30_0

										return arg_30_0
									end
								end

								local var_27_11 = {
									[var_0_8("C\xA2\xE7&A o\xB2\xFC9A", "N0\xC1\x95C$")] = var_27_6(client.screen_size()),
									[var_0_8("%\r\x85\nO1\x13\x85", "!P~\xE0x")] = var_0_8("\xE0\xA7\x11\xC0T\xED\xBC\f\xD6U", "<\x8C\xC8c\xA4"),
									[var_0_8("\x94\xF7\x16/\xB2\x93\xCB\n'\xAF\x82", "\xC2\xE7\x94dF")] = var_0_8("NUѦ\xE4\xDBRCϦ", "\xA8&,\xA1Ö"),
									[var_0_8("\x82\xE9\x8Bz4ץ\x02\x81\xE8\x87", "v\xE0\x9C\xE2\x16P\x88\xD6")] = var_0_8("P\xEBU\x85C\xFD\\", "\xE0\"\x8E9"),
									[var_0_8("˷\xC1\xDCg\xF4b\x1Aת\xC0", "n\xBEǥ\xBD\x13\x91=")] = var_0_8("\x8A\xBA8\xB8؈\x88\xBB%\xBD", "\xA7\xBA\x8B\x17\x88\xEB"),
									[var_0_8("\x16\xBA\x8B\f\x16\x8A\x98\x01\x1B\xAC\x8D\x1F", "mz\xD5\xE8")] = nil,
									[var_0_8("\xF9\xF2\xA3 \xE1\xF9", "P\x8E\x97\xC2")] = nil,
									[var_0_8("\x00\xC7tD\x06", ",c\xA6\x17")] = {
										[var_0_8("}\xF9=?2\xADq", "\xC4\x1C\x97IVS")] = {
											[var_0_8("\xF0\f'\x14\x8BL\x11y\xFD\x10", "\x16\x93cIp\xE28x")] = {
												var_0_8("\x8B}\xE3爼", "\xED\xD8\x15\x82\x95"),
												var_0_8("\xB1Z^Q\xB4\xC0P\x85", ">\xE2.??Щ"),
												var_0_8("\xD2\x18Y\x88\x16\x03(", ">\x85y5\xE3\x7FmO"),
												var_0_8("#\x18=▹\xA3\x1C\x1F;\xFB\xD1", "\xC2ptR\x95\xB6\xCE"),
												var_0_8("\v\xBDB\x16\xC9\xEC\t", "nY\xC8,x\xA0\x82"),
												var_0_8("\x8F\xD6HM", "-ˣ+&#*["),
												var_0_8("\xF6\x90\xDF(Ǥ[Ā", "4\xB2\xE5\xBCC\xE7\xC9"),
												var_0_8("\x00HB", "CA!0d\x97<"),
												var_0_8("\xFE\xF7\xCA\xE4\xA5", "\x93\xBF\x87θ"),
												var_0_8("\xB4-\xA3ʘR\xA1\x97!\xB5\xD5", "\xD2\xE4Hơ\xB83")
											},
											[var_0_8("&\\\xE0\x18L\xCD9G\xF7\x19g\xC79G\xE0", "\xAEV)\x93p\x13")] = {
												[var_0_8("h\b\x8C\x19 \v", "\xCB;`\xEDkEoq")] = 1,
												[var_0_8("\x17\x02\xAD\xEF5\xF9\xD9#", "\xB7Dv́Q\x90")] = 2,
												[var_0_8("9\xAC|\xEF\x02\x8C\t", "\xE2n\xCD\x10\x84k")] = 3,
												[var_0_8("\xD8\xCF\xEF\xCE\x01\xFC\xC2\xEC\xD2H\xE5\xC4", "!\x8B\xA3\x80\xB9")] = 4,
												[var_0_8("eM\n\xD0^V\x03", "\xBE78d")] = 5,
												[var_0_8("r\xBA?\x15", "\x936\xCF\\~s\x83")] = 6,
												[var_0_8(")$6vMs\x02'0", "\x1EmQU\x1Dm")] = 7,
												[var_0_8("\xDExF", "\x9C\x9F\x114\xD6V\xBE")] = 8,
												[var_0_8("\x8F\xE6\xAF\xFC\xAA\xFA\xBE\xB7", "\xDCΏ\xDD")] = 9,
												[var_0_8("\xB6x(\x1C\x98\xCD\xC1\x95t>\x03", "\xB2\xE6\x1DMw\xB8\xAC")] = 10
											},
											[var_0_8("\xF9\xBB\x18\vH\xE1\xF4\xA9", "\x98\x95\xDEj{\x17")] = 0,
											[var_0_8("\xD1#\xE4S\x8A\xC4'\xE1|\xB1\xD8 \xF3M\xA6\xD40\xF3", "սF\x96#")] = 0,
											[var_0_8("CPf\x18pE}\x1CL]", "h/5\x14")] = 0,
											[var_0_8("\xAEM\x8F\t\xBD\x03", "o\xC3,\xE1|\xDC")] = {
												[var_0_8("\xD4C\x06g", "˸&`\x13\xCB")] = false,
												[var_0_8("+z~I\xDA", "\xAEY\x13\x19!")] = false,
												[var_0_8("-\x13QE", "kOr2.\x97\xE7")] = false,
												[var_0_8("5\xA3\xB3=\xB5 \xB6\xD7", "\xA0Y\xC6\xD5I\xEAY\xD7")] = -90,
												[var_0_8("Zx\xB3\xF6\xD1wh\xB5\xE9", "\xA5(\x11Ԟ")] = 90,
												[var_0_8("\xE7\xD8\v8\x19\xFC\xD8\x1F", "F\x85\xB9hS")] = 0
											},
											[var_0_8("\x03WK?\xC7\x00zP#\xCA\x0FV", "\xA9d%$J")] = 0,
											[var_0_8("\x0E\x82\xA7T?\x85\xA3S\v\x94\xB6Q\x02", "0`\xE7\xC2")] = false
										}
									},
									[var_0_8("\xC4S\f>", "\xE3\xA8:nMy\xB8\xCF")] = {
										[var_0_8("x0\xB6P\xB3\xD4p\xB7\x7F", "\xC5\x1B\\\xDF ѻ\x11")] = require(var_0_8("\x04^\xCE\xFE\x10Z\xCD\xE8\x06\x10\xC0\xF7\nO\xC1\xF4\x02M\xC7", "\x9Bc?\xA3")),
										[var_0_8("\x80в\x88\xEF\xD0", "\xE4\xE2\xB1\xC1\xED\xD9")] = require(var_0_8("3\xB1.\xE3'\xB5-\xF51\xFF!\xE7'\xB5u\xB2", "\x86T\xD0C"))
									},
									[var_0_8("\x01\xA9\x80Y\x01\xA9\x88_\x16", "<s\xCC\xE6")] = {
										[var_0_8("\xF5;\xECu", "\x10\x87Z\x8B")] = {
											[var_0_8("Y}\b\fJUuUs\x03", "\x184\x14fS.4")] = ui.reference(var_0_8("\xF6\x0E\x06\x01", "o\xA4OAD"), var_0_8("\xE7Ў\xDC!\xFE", "\x8A\xA6\xB9\xE3\xBEN"), var_0_8("\xE6}\xCB>_6\x14\x8Bp\xC4:S$\x1C", "y\xAB\x14\xA5W2C")),
											[var_0_8("\xCB1\xB7\t\xBD\x03\xCB9\xBE3\x86\r\xD0=\xAB$\xB0\x06\xC3", "b\xA6X\xD9V\xD9")] = {
												ui.reference(var_0_8("\xC4\xD7^$", "\xBC\x96\x96\x19a\xE6"), var_0_8("\xFB\x80R\x00\x03\xF9", "\x8D\xBA\xE9?bl"), var_0_8("\xDC\xE3\"\xBF(\xE4\xE7l\xB2$\xFC\xEB+\xB3e\xFE\xFC)\xA47\xF8\xEE)", "E\x91\x8AL\xD6"))
											},
											[var_0_8("v\xC0\x9B\x8A\xBA)cΏ\x8C", "v\x10\xAF\xE9\xE9\xDF")] = ui.reference(var_0_8("\xB9\xA5\x12\x9E", "\x1D\xEB\xE4Uێ\xEB"), var_0_8("\x1Cݷ\xDFxZ", "2]\xB4ڽ\x17.G"), var_0_8("\xF8\xABIOA\x9C[ߢ^\fT\xD3Aа", "(\xBE\xC4;,$\xBC")),
											[var_0_8(":Jη\xFFB\x0F3A\xC5", "m\\%\xBCԚ\x1D")] = ui.reference(var_0_8("6΃\xE6", ":d\x8FģQ"), var_0_8(";K.\xA10]", "nz\"C\xC3_)\x85"), var_0_8("S\xBEII\xD35\xB3TN\xCF5\xB0RG", "\xB6\x15\xD1;*"))
										},
										[var_0_8("\xB6Y\xD1\x14 \xB7\xBA", "\xDE\xD77\xA5}A")] = {
											[var_0_8(")\xDF\xC7\x18\xFE\xC4\xE9", "*L\xB1\xA6z\x92\xA1\x8D")] = ui.reference(var_0_8("\x84\xAB", "\x16\xC5\xEAe\xAE\x19"), var_0_8("\f:\xB1\xD5;\xAEދ/;\xB1\x9Cw\xA1Њ('", "\xE6MTż\x16Ϸ"), var_0_8("\xDC\x1A\xC7\xFE\x80\xA4\xF4", "U\x99t\xA6\x9C\xEC\xC1\x90")),
											[var_0_8("\xB4\xE9Y\xB0\xEC?\xA9\xEFI\xB6", "`Ā-ӄ")] = {
												ui.reference(var_0_8("\x14\xAC", "\xB8U\xED\x1B?\xB2\xCF\xD4"), var_0_8(")W\x1DVEX\x00R\nV\x1D\x1F\tW\x0ES\rJ", "?h9i"), var_0_8(";\x8E\xB0G\x03", "$k\xE7\xC4"))
											},
											[var_0_8("D\xB4\xB5\xB8_\xB4\xB1\x82", "\xE7=\xD5\xC2")] = ui.reference(var_0_8("(\x8C", "\x13i\xCD]"), var_0_8("\x88\x06ʈr\xA8\x01Ӄ0\xBDHߏ8\xA5\r\xCD", "_\xC9h\xBE\xE1"), var_0_8("\x96\xCA֎\xAD\xCA\xD2\xCB", "\xAEϫ\xA1")),
											[var_0_8("\xEC\xF0\n\xFF\xFD\xC4", "\xB7\x8D\x9Em\x93\x98")] = {
												[var_0_8("5\b\xF1", "lLi\x86")] = {
													ui.reference(var_0_8("\xCA\xE4", "\xAE\x8B\xA5с"), var_0_8("\x82\xBD\xF6ȋ\x02yu\xA1\xBC\xF6\x81\xC7\rwt\xA6\xA0", "\x18\xC3ӂ\xA1\xA6c\x10"), var_0_8("\x7F\x02\xFE", "v&c\x89L3"))
												},
												[var_0_8("\xE4'\x12-\x03)\xE92\x00\x00", "@\x9DFeri")] = {
													ui.reference(var_0_8("a\x89", "p \xC8ǃ"), var_0_8("\r^H\xB1\x8E\xAA+!RS\xAC\x83\xAA,+\\Y\xAB", "BL0<أ\xCB"), var_0_8("\x83\x87n\xB3U\xC70\xAE\x83k", "D\xDA\xE6\x19\x93?\xAE"))
												},
												[var_0_8("\xA9/@U\xB8\xAE", "\xD6\xCDJ3,")] = {
													ui.reference(var_0_8("\xDBm", "\x17\x9A,\x82\x9C"), var_0_8("0\xA8\xB9\xA7{\x12\x18\xAB\xAF\xA1\"S\x10\xA8\xAA\xA23\x00", "sq\xC6\xCD\xCEV"), var_0_8("\xA6X\xFAC\xC4N\xFFM", ":\xE47\x9E"))
												},
												[var_0_8("\xA6\x86\xDC\"", "U\xD4\xE9\xB0N\\\xCD")] = ui.reference(var_0_8("ky", "\x82*8\xE8"), var_0_8("˻0\xEA\r>\xE3\xB8&\xECT\x7F\xEB\xBB#\xEFE,", "_\x8A\xD5D\x83 "), var_0_8("\x18'\xADO", "\x16JH\xC1#"))
											},
											[var_0_8("(|\xF7A\"z\xDB^>|\xE1K8x\xEA\\%w\xE3", "8L\x19\x84")] = ui.reference(var_0_8("\x7F\xE0", "\xAF>\xA1\xCBF"), var_0_8("\x1D\xD3\xD7\x1Ax=\xD4\xCE\x11:(\x9D\xC2\x1D20\xD8\xD0", "U\\\xBD\xA3s"), var_0_8("\x0F\xBE5=:\xB816-\xA5>?i\xAE?<0\xEC)9>", "XI\xCCP")),
											[var_0_8("+\x87\x17C\x16\xC3/\x94", "\xBAN\xE3p&I")] = ui.reference(var_0_8("\xDDv", "\x1A\x9C7\x9D53"), var_0_8("\xAD\xD6\x02\xD0\xF5Q\x85\xD5\x14֬\x10\x8D\xD6\x11սC", "0\xEC\xB8v\xB9\xD8"), var_0_8("\xC0\xB9P5\x8F-\xE4\xAA", "T\x85\xDD7P\xAF")),
											[var_0_8("\xBB\xF5!\xA3\xD4H\xBC\xE9 \xAF\xC9[", "<݇DƧ")] = {
												ui.reference(var_0_8("Ϝ", "\xB9\x8Eݘ\xE3\""), var_0_8("y\xCBC\xF3\x0E2\xFEU\xC7X\xEE\x032\xF9_\xC9R\xE9", "\x978\xA57\x9A#S"), var_0_8("\x86Q\x00\xEB\xB3W\x04\xE0\xA4J\v\xE9", "\x8E\xC0#e"))
											},
											[var_0_8("\xC5y&\xB4\xF0\x8D\xA0\x1D", "v\xB6\x15IÇ\xEC\xCC")] = {
												ui.reference(var_0_8(")\x1D", "\x9Dh\\z dm"), var_0_8("\x8C\xB2\xC7\xCF/", "\xCB\xC3Ư\xAA]G\xED"), var_0_8("\x1DG1\xC2\x11\x1C\xF3:B1\xDB", "\x9CN+^\xB51q"))
											}
										},
										[var_0_8("w\xF0ԯ\x04Jma", "\x19\x12\x88\xA4\xC3k#")] = {
											[var_0_8("\xEC\"\xBCM~\xB9չ\xF8", "؈M\xC9/\x12ܡ")] = {
												ui.reference(var_0_8("\x1F\xCD\f\xFF", "\xE2M\x8CK\xBAh\xBC"), var_0_8("\x98\xC7\xDD=@\xAD", "/ٮ\xB0_"), var_0_8("\x9C\xD2c\x00\xBEQ82\xB9\xCD", "Fؽ\x16b\xD24\x18"))
											},
											[var_0_8("\xD2֧\x82\xC0\xD2з\x94", "\xB3\xBA\xBF\xC3\xE7")] = {
												ui.reference(var_0_8("\xD8\x1E", "\x84\x99_x"), var_0_8("\x9E\xA6\x06(\xE5", "\xC0\xD1\xD2nM\x97\xBA"), var_0_8("\xCF\rb\xFA\xF7\xCB\xF4C#\xE7\xEBͭ\x02+\xE4", "\xA4\x80cB\x89\x9F"))
											},
											[var_0_8("\x06\x88\xE2\xBB\x04\x9C\xEA\xB5", "\xDE`\xE9\x89")] = ui.reference(var_0_8("\x8B\x92\x80:", "\x90\xD9\xD3\xC7\x7F\xE8\x93"), var_0_8("\xD7;6-\xC7", "$\x98O^H\xB5%b"), var_0_8("\xF3\xCDD4\x97\xC8B:ܘF,\xC4\xD1T+", "_\xB7\xB8'")),
											[var_0_8("\xB3>\xEC#X\x81\x05\x8A+\xFE6Q", "b\xD5_\x87F4\xE0")] = ui.reference(var_0_8("߂", "4\x9Eé\x17"), var_0_8("\\\xBD9q\xC69z\x8C", "\xEB\x1A\xDCR\x14\xE6U\x1B"), var_0_8("\xA9\xAC\xE6\xD7z\x9C", "\x14\xE8\xC1\x89\xA2")),
											[var_0_8("$\xDEΣ\xEB\x8D\x10N4\xDEׯ\xE6\x82\x14t", "\x11B\xBF\xA5Ƈ\xECw")] = ui.reference(var_0_8(".\x8E", "\xB1o\xCF\xCEs\x9F\x88\x8C"), var_0_8("#\x88\x1B\x11\x94C^\x02", "?e\xE9pt\xB4/"), var_0_8("\xF5:\xFF\x1B\xF98\xC0>", "V\xA3[\x8Dr\x98")),
											[var_0_8("U\n\x7Fv6R\fKr7\\\x1Ezg", "Z3k\x14\x13")] = ui.reference(var_0_8("\xAC\xD1", "]\xED\x90\xE5\x8F"), var_0_8("3\xF7\xFB\x1CKJ\x14\xF1", "&u\x96\x90yk"), var_0_8("\x01\xB2\xE339", "ZMێ"))
										},
										[var_0_8("\xF0\r2,M\vi", "\x1A\x86dAY,g")] = {
											[var_0_8("\xE5\xEB91\xA0\xE1\xE6\"0\xAB\xFF", "đ\x83PC")] = {
												ui.reference(var_0_8("\b\xB9\x15\x1D\x19\xE4\r", "\x88~\xD0fhx"), var_0_8("]\x8C\xC8F\xACF.", "1\x18\xEA\xAE#\xCF2]"), var_0_8("*\xFD\xEF\x8BtL\xE6\xF5\x81c\b\xB2\xED\x8Dc\x1F\xFD\xF3\xC89\r\xFE\xF4\x9EtE", "\x11l\x92\x9D\xE8"))
											}
										},
										[var_0_8("F\xCA\a\xEE", "\xC8+\xA3t\x8DO")] = {
											[var_0_8("\xBE#)\x8C\xA0\xF1\xE6\xB4", "\x83\xDFV]\xE3Д")] = {
												ui.reference(var_0_8("\xD1d\x91\x93", "Ճ%\xD6\xD6}"), var_0_8("\t?-\xBA\xF3", "\x81FKE\xDF"), var_0_8("w\xDE\xFA\xEAw\xAFV\xCE\xF6\xE2<\xEEU\xD8\xFA\xFAh", "\x8F&\xAB\x93\x89\x1C"))
											},
											[var_0_8("֐\xBC\xF6\x10\xF7\xD5ކ\xB0\xFD\x04", "\xB4\xB0\xE2ٓc\x83")] = {
												ui.reference(var_0_8("\xF2\x98", "g\xB3\xD9O"), var_0_8("k\xB9\b\xDC\f\x8D\xAAG\xB5\x13\xC1\x01\x8D\xADM\xBB\x19\xC6", "\xC3*\xD7|\xB5!\xEC"), var_0_8("+K2;6\xEC\fW37+\xFF", "\x98m9W^E"))
											},
											[var_0_8("\xFC\xD6\x19\xBA\x81\xC1@\xBA\xF8\xD1\x0F", "ș\xB7j\xC3޲4")] = ui.reference(var_0_8("?\xEA\x9B>", ":R\x83\xE8])"), var_0_8("\xAEX\xC6\x10P:\x8DC", "_\xE37\xB0u="), var_0_8("=\x7F0R\xEB\vj1J\xAD\x1D", "\xCBx\x1EC+")),
											[var_0_8("\xE21_\xEE\xDF\xF4", "\xB9\x91E-\x8F")] = ui.reference(var_0_8("\x87\x16\n\xA5", "\xBC\xEA\x7Fy\xC6"), var_0_8("\x15=\x05\x8657\x1D\x97", "\xE3XRs"), var_0_8("b\x16\xA8\xE7\x11gQ\x1E\xBC\xA2", "\x13#\x7F\xDA\xC7b")),
											[var_0_8("\x0F\xEF\x18\xE3\x1A\xFE5\xF1\x11\xF4\x05\xF6\x14", "\x82|\x9Bj")] = ui.reference(var_0_8("\xD8\xC2\xE5\xAC", "ߵ\xAB\x96\xCFÖ\x1C"), var_0_8("a5\xF5\xAB\x04I4\xF7", "i,Z\x83\xCE"), var_0_8("\xDE\xE9\xA0\xF9\x1B*\xEDᴼH-\xF2ｭ\x007\xF1\xE7", "^\x9F\x80\xD2\xD9h")),
											[var_0_8("_\xEF\x03\xADMv\xFD\x7Fo\xFF\t\xA9", "\x1A0\x99f\xDF?\x1F\x99")] = ui.reference(var_0_8("\x0FI\xFE\xF0", "\x93b \x8D"), var_0_8("5J\xF0\xC9\x03ZG\x19M\xE6\xC5\x13E", "+x#\x83\xAAf6"), var_0_8("{\x10\x82\xA4\xB7\xB9\x80QF\xA1\x99\x93", "\xE44f\xE7\xD6\xC5\xD0")),
											[var_0_8("\x11\xF6p\xD8\xF8\x82\x1D\xD3!\xFAz\xC5\xE7\xB4\x1F\xD9\b", "\xB6~\x80\x15\xAA\x8A\xEBy")] = ui.reference(var_0_8("\x86\xD3&\xE5", "f\xEB\xBAU\x86\xE6sP"), var_0_8("z\x05-\\w\xD8.V\x02;Pg\xC7", "B7l^?\x12\xB4"), var_0_8(";\x9B\x80%5P\x10\x88\xC5-(V\x19ͣ\x18\x11", "9t\xED\xE5WG"))
										}
									},
									[var_0_8("\xA9\xA7\xEC\xF5", "'\xCAэ\x87\x17\x8E")] = {
										[var_0_8("\xEC%6\r \xF9\xE9:\x1D\x13", "\x98\x9FSijR")] = client.get_cvar(var_0_8("\x92\xD0n\xF5\xDB]\x97\xCFE\xEB", "<\xE1\xA61\x92\xA9")),
										[var_0_8("<\b\x10 \x14\n?!&'\x11\x12#\r*", "gO~OJa")] = client.get_cvar(var_0_8("\xA9i\xECyK\x17\xAA@\xDA~N\x0F\xB6l\xD6", "z\xDA\x1F\xB3\x13>"))
									},
									[var_0_8("\xB0\xD0\xCA", "%Ӷ\xAD\xA1\xA9\xC1")] = {},
									[var_0_8("\xF13A\xDC;b\xAA\xE3?@", "ٗZ-\xB9H\x1B")] = {},
									[var_0_8("\xCD}\xF3\x1B@\xC6", "6\xA3\x1C\x87r")] = {
										[var_0_8("/\xDEI\xBDMs!\xDES\x96qz&\xCFT\x96W", "\x1FH\xBB=\xE2.")] = vtable_bind(var_0_8("\xC0\nJ\xD7Ijj\xC7\nO", "D\xA3f#\xB2'\x1E"), var_0_8("\x88S\xD6\xCE\x06\xBB\x974\xB0d\xD3\xD3\x1A\x99\x8A\x02\xAA \x8A\x94", "q\xDE\x10\xBA\xA7c\xD5\xE3"), 3, var_0_8("8\x01\xF2\xF2dF\xC4\xC9:\x06\xF2\xE5-\x0F\xF7\xFAdG\xB3\xE0!\a\xFF\xBCbN\xF2\xF8:G", "\x96Nn\x9B"))
									}
								}
								local var_27_12 = {
									{
										var_0_8("\x97\xC0*\xEE\xB2\x1B\x80S\x80\xC45\xE2\xAC!\xAFA\x91\xCD", " \xE5\xA5G\x81\xC4~\xDF"),
										"U\x8B\xEC\x81\xEC\xCC\xCC\xCC̋U\bS\x8B\xD9",
										var_0_8("Նͅ\xC9\xEA\xFC\x9D̈\x92\xD6\xC2\x85\xC8\xCBȝՆͅ˙\x83\x8Aˏ\x92\xC1\x83\x8À\x93\x9F\x8F\xC9ǎ\x8F\xC6\xD7\xC9ǉ\x80ǉ\xC0", "\xB5\xA3\xE9\xA4\xE1\xE1")
									},
									{
										var_0_8("B\x8E3xF\x8E\x01qY\x87;", "\x170\xEB^"),
										"U\x8B\xEC\x81\xEC\xCC\xCC\xCC̍\x85\xCC\xCC\xCC\xCCVP\x8DE\f",
										var_0_8("j\xD5\xD1Y\x1F\f\xEDh\xD2\xD1NT2\xDEp\x90\x91\x15A<\xDBx\x90\x94\x1DT<\xDCoΘ^_2\xC06\x96\x98^X=\xC1h\x9A\xDBUV!\x985", "\xB2\x1C\xBA\xB8=7S")
									},
									{
										var_0_8("\xC2\xC4I8\xCD\x00\xF0\xDC\xD9", "\x95\xA4\xAD'\\\x92n"),
										"U\x8B\xEC\x83\xEC\fS\x8Bً\r\xCC\xCC\xCC\xCC",
										var_0_8("\xF0(\x1E\f\x0E[\xF0/\x11\rPS\xCC\x18\x04\x17\x13\b\xF0&\x1C\x13PR\xBB1\x1F\x16\x1EQ\xBFg\x19\x11\x0ER", "{\x93Gp\x7Fz")
									},
									{
										var_0_8("\xCAČuy\xC5޽uO\xDEȁeI\xDE\xD4", "&\xAC\xAD\xE2\x11"),
										"U\x8B\xEC\x0F\xB7E\b",
										var_0_8("O\x1E#\xE3\x05.\x13\xFBE\x18?\xECL\x1D \xA5\x04Y:\xE0D\x15f\xA3\r\x18\"\xFB\x04", "\x8F-qL")
									},
									{
										var_0_8("\xBE\xB1\x128\x87\xBB\x103\xAB\xBD", "\\\xD8\xD8|"),
										"U\x8B\xECS\x8B]\b\x85",
										var_0_8("M=\xA5D\xB5d\r\xB8H\xF4H1\xADL\xF1\x11{\xE4V\xF2R6\xE6\f\xBDR<\xB8\t", "\x9D;R\xCC ")
									},
									{
										var_0_8(">7\xED\xFE\xD6\xECڣ+*", "\xD1X^\x83\x9A\x89\x8A\xB3"),
										"U\x8B\xECj\x00\xFFu\x10\xFFu\f\xFFu\b\xE8\xCC\xCC\xCC\xCC]",
										var_0_8("+\xAE\xCAo\nc2*)\xB3\x8E4!\x1C%*!\xB2\xC7}\x12/{k`\xB7\xCBu\x1Ai}b+\xAE\xCAo\nc2*)\xB3\x8E0^ >,;\xB5\x84\x7F\x16\"#hd\xE1\xCDr\nix", "BH\xC1\xA4\x1C~CQ")
									},
									{
										var_0_8("\xE0)\xBCg%c\xF5>\xADV2I\xE3%\xBA]%b\xE8>\xB1", "\x16\x87L\xC88F"),
										"U\x8B\xECV\x8Bu\bV\xFFu\f",
										var_0_8("\x8F?\xF7(\x15޲$\xF0-N\xE2\x8C<\xF4n\x14\xA9\x9B?\xF1 \x17\xAD\xCD3\xF0%O\xAB\xC1p\xF1*I\xA8", "\x81\xEDP\x98D=")
									}
								}

								local function var_27_13(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
									local var_31_0 = 0
									local var_31_1
									local var_31_2
									local var_31_3
									local var_31_4
									local var_31_5
									local var_31_6

									while true do
										if var_31_0 == 3 then
											while true do
												local var_31_7 = 0

												while true do
													if var_31_7 == 1 then
														if var_31_1 == 1 then
															local var_31_8 = 0

															while true do
																if var_31_8 == 1 then
																	var_31_1 = 2

																	break
																end

																if var_31_8 == 0 then
																	local var_31_9, var_31_10 = pcall(var_27_7.typeof, arg_31_3)

																	var_31_5 = var_31_10

																	if not var_31_9 then
																		error(var_31_5, 2)
																	end

																	var_31_8 = 1
																end
															end
														end

														break
													end

													if var_31_7 == 0 then
														if var_31_1 == 0 then
															local var_31_11 = 0

															while true do
																if var_31_11 == 0 then
																	var_31_2 = client.create_interface(arg_31_0, arg_31_1) or error(var_0_8("X\xA6\x12\xF2\x10\x1E\\\x11\xA1\n\xE7\x19\x05^P\xAB\x01", "81\xC8d\x93|w"), 2)
																	var_31_3 = client.find_signature(arg_31_0, arg_31_2) or error(var_0_8("\xC50\xA9\xF1\xC07\xBB\xB0\xDF7\xB8\xFE\xCD*\xAA\xE2\xC9", "\x90\xAC^\xDF"), 2)
																	var_31_11 = 1
																end

																if var_31_11 == 1 then
																	var_31_1 = 1

																	break
																end
															end
														end

														if var_31_1 == 2 then
															local var_31_12 = 0

															while true do
																if var_31_12 == 0 then
																	local var_31_13 = 0

																	while true do
																		if var_31_13 == 0 then
																			local var_31_14 = var_27_7.cast(var_31_5, var_31_3) or error(var_0_8("-\x01\xB4F(\x06\xA6\a0\x16\xB2B'\x0E\xB1S", "'Do\xC2"), 2)

																			return function(...)
																				return var_31_14(var_31_2, ...)
																			end
																		end
																	end
																end
															end
														end

														var_31_7 = 1
													end
												end
											end

											break
										end

										if var_31_0 == 1 then
											local var_31_15 = 0

											while true do
												if var_31_15 == 0 then
													var_31_3 = nil

													local var_31_16

													var_31_15 = 1
												end

												if var_31_15 == 1 then
													var_31_0 = 2

													break
												end
											end
										end

										if var_31_0 == 2 then
											var_31_5 = nil

											local var_31_17

											var_31_0 = 3
										end

										if var_31_0 == 0 then
											var_31_1 = 0
											var_31_2 = nil
											var_31_0 = 1
										end
									end
								end

								for iter_27_0 = 1, #var_27_12 do
									local var_27_14 = 0
									local var_27_15

									while true do
										if var_27_14 == 0 then
											local var_27_16 = var_27_12[iter_27_0]

											var_27_11.filesystem[var_27_16[1]] = var_27_13(var_0_8("Я\xEB\xC2j\xAEŲ\xE2\xCAF\xA4¢\xEE\xC87\xB3ڪ", "׶Ƈ\xA7\x19"), var_0_8("\xBBo\xE3D\x88z\xF3[\x99L\xE7\x18\xDC\x1E", "(\xED)\x8A"), var_27_16[2], var_27_16[3])

											break
										end
									end
								end

								local var_27_17 = vtable_bind(var_0_8("\xC1}\xF6\xFDY\xDEg\xEE\xFDG\xF8g\xEE\xFCC\xC8:\xFE\xF4F", "*\xA7\x14\x9A\x98"), var_0_8("|ثNt\x12S\xED\xB6G|q\x1B\xA9", "A*\x9E\xC2\"\x11"), 11, var_0_8("\f([\be\xD2$\xFA\x12.A\x0F,\xE1\x17\xA4SoD\x03$\xE9Q\xA2Z$]\x02>\xF9[\xED\x12&@Fa\xAD\x18\xE1\x144FL.\xE5\x1A\xFCPk\x12\x05#\xF9R", "\x8EzG2lM\x8D{"))
								local var_27_18 = var_27_7.typeof(var_0_8("\x16\xAA\xFE\n\x00D\xF0\xA7%", "[u\xC2\x9Fx"))()

								var_27_11.filesystem.get_current_directory(var_27_18, var_27_7.sizeof(var_27_18))

								local var_27_19 = string.format(var_0_8("_\x0E", "Dz}^xU\x91"), var_27_7.string(var_27_18))

								var_27_17(var_27_19, var_0_8("$=\xE2a\xFB\xF6\x8F98\xF0|\xE7\xF8\x883", "\xDAw|\xAF>\xA8\xB9"), 0)

								function var_27_11.cfg.get()
									local var_33_0 = 0
									local var_33_1
									local var_33_2
									local var_33_3
									local var_33_4

									while true do
										if var_33_0 == 2 then
											while true do
												local var_33_5 = 0

												while true do
													if var_33_5 == 1 then
														if var_33_1 == 1 then
															local var_33_6 = 0

															while true do
																if var_33_6 == 1 then
																	var_33_1 = 2

																	break
																end

																if var_33_6 == 0 then
																	while var_33_4 ~= nil do
																		local var_33_7 = 0
																		local var_33_8
																		local var_33_9

																		while true do
																			if var_33_7 == 0 then
																				var_33_8 = 0

																				local var_33_10

																				var_33_7 = 1
																			end

																			if var_33_7 == 1 then
																				while true do
																					if var_33_8 == 0 then
																						local var_33_11 = 0
																						local var_33_12

																						while true do
																							if var_33_11 == 0 then
																								local var_33_13 = 0

																								while true do
																									if var_33_13 == 0 then
																										local var_33_14 = var_27_7.string(var_33_4)

																										if not var_27_11.filesystem.find_is_directory(var_33_3[0]) and var_33_14:find(var_0_8("ҭ\x9Ek\x15\xA1@(⫂5\x04\xABG", "\\\x8D\xC5\xE7\x1Bp\xD33")) then
																											var_33_2[#var_33_2 + 1 + 0] = var_33_14
																										end

																										var_33_13 = 1
																									end

																									if var_33_13 == 1 then
																										var_33_8 = 1

																										break
																									end
																								end

																								break
																							end
																						end
																					end

																					if var_33_8 == 1 then
																						var_33_4 = var_27_11.filesystem.find_next(var_33_3[0])

																						break
																					end
																				end

																				break
																			end
																		end
																	end

																	var_27_11.filesystem.find_close(var_33_3[0])

																	var_33_6 = 1
																end
															end
														end

														break
													end

													if var_33_5 == 0 then
														if var_33_1 == 2 then
															return var_33_2
														end

														if var_33_1 == 0 then
															local var_33_15 = 0

															while true do
																if var_33_15 == 0 then
																	var_33_2, var_33_3 = {}, var_27_7.typeof(var_0_8("\xAC\xFE\\\xFF\xF4\xCD", "\xA4Ő("))()
																	var_33_4 = var_27_11.filesystem.find_first("*", var_0_8("\xB0ч\xB4ގ\xB4\xFF\x99\xA2\xC2\x8E", "\xD6\xE3\x90\xCA\xEB\xBD"), var_33_3)
																	var_33_15 = 1
																end

																if var_33_15 == 1 then
																	var_33_1 = 1

																	break
																end
															end
														end

														var_33_5 = 1
													end
												end
											end

											break
										end

										if var_33_0 == 0 then
											local var_33_16 = 0

											while true do
												if var_33_16 == 1 then
													var_33_0 = 1

													break
												end

												if var_33_16 == 0 then
													var_33_1 = 0
													var_33_2 = nil
													var_33_16 = 1
												end
											end
										end

										if var_33_0 == 1 then
											local var_33_17 = 0

											while true do
												if var_33_17 == 0 then
													var_33_3 = nil
													var_33_4 = nil
													var_33_17 = 1
												end

												if var_33_17 == 1 then
													var_33_0 = 2

													break
												end
											end
										end
									end
								end

								function var_27_11.cfg.update()
									local var_34_0 = 0
									local var_34_1
									local var_34_2
									local var_34_3

									while true do
										if var_34_0 == 1 then
											local var_34_4

											while true do
												local var_34_5 = 0
												local var_34_6

												while true do
													if var_34_5 == 0 then
														local var_34_7 = 0

														while true do
															if var_34_7 == 0 then
																if var_34_1 == 1 then
																	local var_34_8 = 0
																	local var_34_9

																	while true do
																		if var_34_8 == 0 then
																			local var_34_10 = 0

																			while true do
																				if var_34_10 == 0 then
																					for iter_34_0 = 1, #var_34_2 do
																						var_34_4[iter_34_0] = var_34_2[iter_34_0]:gsub(var_0_8("\xD9\xF7\x93\xB3\xD4\xF4재\xDF㱞\xBB\xC5", "\xB1\x86\x9F\xEA\xC3"), "")
																					end

																					return var_34_4
																				end
																			end

																			break
																		end
																	end
																end

																if var_34_1 == 0 then
																	local var_34_11 = 0

																	while true do
																		if var_34_11 == 1 then
																			var_34_1 = 1

																			break
																		end

																		if var_34_11 == 0 then
																			var_34_2 = var_27_11.cfg.get()
																			var_34_4 = {}
																			var_34_11 = 1
																		end
																	end
																end

																break
															end
														end

														break
													end
												end
											end

											break
										end

										if var_34_0 == 0 then
											var_34_1 = 0
											var_34_2 = nil
											var_34_0 = 1
										end
									end
								end

								local var_27_20 = {
									[var_0_8("\xAE\xE8-\xA9٩\xD41\xA1ĸ", "\xA9݋_\xC0")] = ui.new_label(var_0_8("\xF2\xBE^", "F\xBE\xEB\x1F_B"), "A", var_0_8("\xF7\xBCZ\xA6", "\x85ڂz\x86") .. ("\a%02x%02x%02x%02x%s"):format(125, 255, 125, 255, var_27_11.script_name)),
									[var_0_8("(\xFE\xE1", "X\\\x9F\x83\xA4\xBC\xC3")] = ui.new_combobox(var_0_8("\xAC\x1B\x9E", "\xBD\xE0N\xDF+\xB7\x8B"), "A", var_0_8("\x1A\xFD\x88V\xD2+\xF0\x8F\x15\xD5!\xEE", "\xA1N\x9C\xEAv"), {
										var_0_8("\x8F\xB8\xC4\xD9", "\xBC\xC7ש"),
										var_0_8("\xCE\bX~\xEA\xF3\x1D", "\x88\x9Ci?\x1B"),
										var_0_8(":\x82m=\x1A\x85t", "T{\xEC\x19"),
										var_0_8("Ƃ\xB9\x02\xAD\xB9\xE3", "Ր\xEB\xCAw\xCC"),
										var_0_8("\x0E\x11\xCD)", "-Cx\xBEJHC"),
										var_0_8("\x13'\xF9\xB1\xF0\x86\xE9\xFA", "\x89@B\x8Dř\xE8\x8E")
									}),
									[var_0_8("\x16\xC3'\xB4\x86\x02\xDD'", "\xE8c\xB0B\xC6")] = ui.new_label(var_0_8("\xC0\x14\t", "L\x8CAHf\x1B\xED\x99"), "A", var_0_8("\a\x84V\xE5\xD2\r\xBDE\xD7\x13\x92\xD5\x00\xBDA\x96V", "\xDE*\xBAv\xB2\xB7a") .. var_27_11.username),
									[var_0_8("H\xFC@\x8BI\xE9{\x9ET\xE1A", "\xEA=\x8C$")] = ui.new_label(var_0_8("\r\xE8\x9B", "oA\xBD\xDA\x12"), "A", var_0_8("\x0E\x15[\x19\nO\xBB\x03^\v1\nH\xAA\x19\v", "\xCF#+{Uk<") .. ("\a%02x%02x%02x%02x%s"):format(255, 255, 125, 255, var_27_11.update_time)),
									[var_0_8("r\xBF\xA9\xE6}O\xB9\xB4\xEBmu", "\x19\x10\xCA\xC0\x8A")] = ui.new_label(var_0_8("\xD1\xFE\x8C", "\x94\x9D\xAB͂\xC9"), "A", var_0_8("n\x8A4\n\xC4\xE41\xD1z=\x91\xF46\xDDx-\x8B\xB6", "\x96C\xB4\x14I\xB1") .. ("\a%02x%02x%02x%02x%s"):format(125, 125, 255, 255, var_27_11.build_state)),
									[var_0_8("\x8C\r\x0EB\xB2\x10\x15@\x88", "-\xEDxz")] = ui.new_checkbox(var_0_8("\xFB݃", "L\xB7\x88\xC2"), "A", var_0_8("7\xB8\xA5\x19E[\x1B:\xEE\xEA5U\x0F\x00{\xE4", "t\x1A\x86\x85X0/")),
									[var_0_8("\x1Aȳ\xE7\xB2`\x1A", "\x12~\xA1\xC0\x84\xDD")] = ui.new_button(var_0_8("s\x1D\x8F", "6?H\xCEd"), "A", var_0_8("\xE2VLt\xA5t\xDDK\x05~\xECh\xCBVW~", "\x1B\xA89%\x1A\x85"), function()
										return
									end),
									[var_0_8("?\xAB{\xAD\xD5\"\xBE", "\xB7M\xCA\x1C\xC8")] = {
										[var_0_8("\x032\x8B", "hwS\xE9")] = ui.new_combobox(var_0_8("\xD9\xCD\x06", "#\x95\x98GB"), "A", var_0_8(":\xE0K\xBC>Y\xFBG\xBC?\x1A\xFCM\xA2", "Zy\x88\"\xD0"), {
											var_0_8("\xF0\vT\x0E\xC8\x00", "~\xA7n5"),
											var_0_8("\x18\b>\xF4\xD36)\x03", "_]pN\x98\xBC")
										}),
										[var_0_8("\xD6\xF0\x84\x05\xEB\xB0", "\xB2\xA1\x95\xE5u\x84\xDE")] = {
											[var_0_8("\x84\xDAߩ\xAD", "C軽\xCC\xC1v\xC6")] = ui.new_label(var_0_8("\xA7\x1B\x94", "\x8F\xEBN\xD5@[b"), "A", var_0_8("\xB8X\x80\xE8d\xB3\xCD[\x8B\xE6~\xF8\xC3\x06\xCA", "\xD6\xED(\xE4\x89\x10")),
											[var_0_8("\x91\xFA\xFF\xDC", "\xC6像\xB9c")] = ui.new_combobox(var_0_8("}\xB9\x89", "\x131\xEC\xC8"), "A", var_0_8("\xC92\xF7\xA7봾#\xEF\xA7\xE1", "ڞW\x96ׄ"), {
												var_0_8("\xC8=\xF8\xD0{p\x9D\xB49\x8A\xD1\x11s", "\xAD\x9B~\xB9\x82VB"),
												var_0_8("֕\x9D\x87ش", "\x8C\x85\xC6ڧ\xE8"),
												var_0_8("\x94\x19\x84", "\xE4\xD5N\xD4\x1D"),
												var_0_8("\xB5\x14\xF67\xEE\x91C\xBA\x13\xEE\x95", "\x8B\xE7,\xD6e"),
												var_0_8("\xFD\xEA\x15[\x02\xA5q3\xD8\xE8\n[", "v\xB9\x8Ff>p\xD1Q"),
												var_0_8("ly:\xF2\xAA\x19", "X<\x10I\x86\xC5u|")
											})
										},
										[var_0_8("U\xF2\xE8\xC4NY\xFE\xEB", "!0\x8A\x98\xA8")] = {
											[var_0_8("~\x172T\xCD", "W\x12vP1\xA1")] = ui.new_label(var_0_8("`+\xFB", "\xD0,~\xBA\xC0"), "A", ("\a%02x%02x%02x%02x%s"):format(255, 255, 125, 255, var_0_8("\xC0\x1B\xB6\xC8\x1D\xF2\xCE\x02\xB7\x0E\xAC\xC3\a\xF9\x89H\xE2\x14\xA7\xD2\x1D\xF3\xC7]\xB7\x17\xAD\xC1\x1C\xE8\x89L\xF2Z\xB1\xC8\a\xE8\xC8L\xFB\x1F\xE5", ".\x97zĦt\x9C\xA9"))),
											[var_0_8("\xE0\xF5R\x1F\xF5\xE1\xD2V\x1F\xFE\xEE", "\x9B\x85\x8D&z")] = ui.new_checkbox(var_0_8("\t\x1F\x8D", "\xC5EJ\xCC!/\x1F"), "A", var_0_8("\xD5WN\x82\xFEK_\x83\xB0__\x82\xFB\x0F\x12\x83\xE4\x0FU\x89\xFCV\x13", "\xE7\x90/:")),
											[var_0_8("\xA0\xDD\xDE`\x1B8\xF0+\xB7\xDF\xD3f\f8\xDD\x06\xA1\xD0\xD5a'9\xCA5\xB3\xC1", "YҸ\xBA\x15x]\xAF")] = ui.new_checkbox(var_0_8("\x9Df]", "Z\xD13\x1C\xB5\x19"), "A", var_0_8("\xE2~S\xFB\xBC\xD5;E\xEB\xB8\xD9hC뭐h_᫐\x7FR\xE2\xBE\xC9", "߰\x1B7\x8E")),
											[var_0_8("\"\xBAŰ(\xBA\xC9", "\xD5Dۮ")] = ui.new_combobox(var_0_8("'\xD5\x02", "\x1Fk\x80C\x87J\xA5_"), "A", var_0_8("\xF9\xEC\xEALO\xB2\xDD\xEC\xBCK@\xBA\xDD\xE4\xFDJ", "Ѹ\x88\x9C-!"), {
												var_0_8("#\xC1f\t\xBA\v\xCDq", "\xD8g\xA8\x15h"),
												var_0_8("^\xA1V\xA7l\xACW\xA1", "\xC4\x18\xCD#"),
												var_0_8("\x18\x8E\xEF\t-\x82\xF7\x1Fn\x89\xE2\x15+\x8F", "fN\xEB\x83"),
												var_0_8("\xD8<1ELy\xBB5\xFD-;IW", "T\x9ANT$'Y\xD7")
											}),
											[var_0_8("\xFB\xE0]]\t\xFC\xE6iY\b\xF2\xF4XL", "e\x9D\x8168")] = ui.new_slider(var_0_8("1\x9C\xAB", "\x19}\xC9\xEA\xCBC"), "A", var_0_8("U\xF5\x1FC\x18.\x1Ep\xE0", "s\x19\x94xctG"), 1, 14, 14),
											[var_0_8("\r1\xB5+V3(\xB77@\n8\x86'I\r/\xBE!", "!l]\xD9D")] = ui.new_checkbox(var_0_8("\xF7~\x80", "ͻ+\xC1"), "A", var_0_8("\xDF~\t\xD0\xE92\x10\xD1\xEDs\x03ھq\r\xDE\xECu\x00", "\xBF\x9E\x12e")),
											[var_0_8("\xC4ʕ\xBB\xAE\xC2", "ϥ\xA3\xE7\xD7")] = ui.new_hotkey(var_0_8("\xEA\xCC\xD8", "\x10\xA6\x99\x996D"), "A", var_0_8("\xF3\xBA\xD2J5&", "\x99\xB2Ӡ&TA"), false)
										}
									},
									[var_0_8("\x83\x05N\"\x83\x02W", "K\xE2k:")] = {
										[var_0_8("K\xDF\x17\x7F\x05\xDB", "\xAD8\xBEq\x1Aq\xA2")] = ui.new_multiselect(var_0_8("\xE7\xEB\f", "\x97\xAB\xBEMe"), "A", var_0_8("\xF6.\xFE\xAC\xECd", "k\xA5O\x98ɘ\x1D"), {
											var_0_8("x@\xA8\xD1QjD", "\x1F7.\x88\xAB4"),
											var_0_8("\xFE&\x9C\xFF\xDF!\xDA\xF1", "\x94\xB1H\xBC"),
											var_0_8("\x84\xB7Tص\xA2V\xD1", "\xB3\xC6\xD67")
										})
									},
									[var_0_8("\xE6\x05acD\xDF\xE3", "\xB3\x90l\x12\x16%")] = {
										[var_0_8("Ң\x19", "\xAF\xA6\xC3{\xE9")] = ui.new_combobox(var_0_8("\xC3\xF7|", "\x90\x8F\xA2=)"), "A", var_0_8("\xC3\xDB\x14\\v\xC7 \xE5\xDF\x18Sf\x88!", "S\x80\xB3}0\x12\xE7"), {
											var_0_8("n\xB4\xE1\xD8B\x10", "~=ד\xBD'"),
											var_0_8("O\xF0\x0FI|", "%\x18\x9F}")
										}),
										[var_0_8("ɥgGߨ", "\"\xBA\xC6\x15")] = {
											[var_0_8("\xEF\x01\xCBY\xCD\xEF\x1B", "\xA2\x98h\xA5=")] = ui.new_multiselect(var_0_8("\xE1\x1A\x93", "\x85\xADO\xD2\x1D\x10"), "A", var_0_8("\xBAu\xE3/\x82k\xFE", "K\xED\x1C\x8D"), {
												var_0_8("\xEB^ش=\x16\xE6\xF3\xD7", "\x81\xBC?\xAC\xD1O{\x87"),
												var_0_8("k\xE1\xFF\xCFI\xEA\xE2\xDE", "\xAD \x84\x86"),
												var_0_8("b\x14\x0F\xFC", "\xAD.{h\x8F\xCEQ"),
												var_0_8("\x87\x11-\x9D@\x87A\xB0\x125\x84", "a\xD4}B\xEA%\xE3")
											}),
											[var_0_8("\x9D\xEA\xB81\x11\x9D\xF0\x89!\x16\x8F\xEE\xB3", "~\xEA\x83\xD6U")] = ui.new_color_picker(var_0_8("\xA8\xE0h", "/\xE4\xB5):"), "A", var_0_8("\x91\xF5\xD7?\f'\f\xE6\xE8\xD1>\x0E5", "\x7FƜ\xB9[cP"), 125, 255, 125, 200),
											[var_0_8("\xFC\x14\xC8\xF9\xA4\n-\xD1\xE7\t", "\xBE\x95z\xAC\x90\xC7kY")] = ui.new_multiselect(var_0_8("\x1E0\xD0", "\x9ERe\x91\x9E"), "A", var_0_8("Y\xF0\x06\x1FGq\xEA\r\x04W", "$\x10\x9Ebv"), {
												var_0_8("\xE3\x13\xCD\xEF]\xFA", "\x85\xA0v\xA3\x9B8\x88G"),
												var_0_8("ң|\xF3\xB1\x1A", "Ֆ\xC2\x11\x92\xD6\x7F")
											}),
											[var_0_8("\x12\xA7\xA0\xDDE\xA5\xB69\t\xBA\x9B\xC0N\xA1\xAF3", "V{\xC9Ĵ&\xC4\xC2")] = ui.new_color_picker(var_0_8("\xDB\xDD\xF8", "ϗ\x88\xB9"), "A", var_0_8("\x81\x8D,\x8Bwye\xA7\x91;\xC2`pt\xA5\x86", "\x11\xC8\xE3H\xE2\x14\x18"), 125, 255, 125, 200)
										},
										[var_0_8("\xA7N\t\xDB\xCD", "\x9F\xD0!{\xB7\xA9\x91\x8F")] = {
											[var_0_8("\xFE[+\"\xCDI09\xE6e57\xE0Q=$", "V\x92:X")] = ui.new_checkbox(var_0_8("t\xEA\xCB", "\x9A8\xBF\x8A\xA0ΉV"), "A", var_0_8("\xAAX\xE6\x93<)\x89Ò\x19\xF8\x86n1\x84\xDE", "\xAC\xE69\x95\xE7\x1CZ\xE1")),
											[var_0_8("\x11\xA4\x87\xC2$\xD2\f\xAF", "\xBBb\xCA\xE6\xB2H")] = ui.new_checkbox(var_0_8("\rԅ", "*A\x81\xC4P"), "A", var_0_8("1D\\\xCA\x1B\x0E\f\xEB", "\x8Eb*=\xBAwgb")),
											[var_0_8("<\xBA\x04\r6\xAC\v\x1E=\x80\x00\a ", "hX\xDFb")] = ui.new_checkbox(var_0_8("h\xC2\xC3", "\x8D$\x97\x82\xAEb"), "A", var_0_8("\xA0\x7F\xC4\b\x8Ai\xCB\x1B\x81:\xC0\x02\x9C", "m\xE4\x1A\xA2")),
											[var_0_8("R\xE4\xEEl\xDF\xF5[\xE0\xF3G\xE2\xE9F", "\x86>\x85\x9D\x18\x80")] = ui.new_checkbox(var_0_8("+\x90;", "\xB6g\xC5z\xB9O\xD1"), "A", var_0_8("Ë\xE0n\x05Z\xB3\x83\xEEe\rI\xFD\x84\xF87\x13@\xFC\x90\xE4e", "(\x93\xE7\x81\x17`")),
											[var_0_8("t\xFC\x8DU\xAF\xA5\xCApǊJ\xAD", "\xBC\x15\x98\xEC%\xDB\xCC")] = ui.new_checkbox(var_0_8("l\xDC\x16", "l \x89W"), "A", var_0_8("\x8B\xE6\t\xAB.\xEDN\x19\xAC\xE7\x16\xE68\xF1BU\xAF\xA8\t\xA8o\xF8BK", "9ʈ`\xC6O\x99+")),
											[var_0_8("\xAA'\xAB\xB7\x99\xAE\xEE\xAE\x1C\xAC\xA8\x9B\x98\xF9\xA6,\xBF\xA9\x99", "\x98\xCBC\xCA\xC7\xED\xC7")] = ui.new_slider(var_0_8("\xD6v\x81", "\x86\x9A#\xC0o\x7F\x15\x19"), "A", var_0_8("\x974\x00\r)ܹ*I\f/\xC4", "\xB2\xD8Fij@"), 1, 130, 115),
											[var_0_8(">%s\xFB\xC8\xC1ѿ%$u\xFB\xF6\xD3ۖ", "\xE0_K\x1A\x96\xA9\xB5\xB4")] = ui.new_checkbox(var_0_8("'\xEF\xF9", "\x16k\xBA\xB8H$\xCC"), "A", var_0_8("Ƴ-C\x0F\xF3\xB8dT\x01\xE8\xB0dH\x01\xF1", "n\x87\xDDD.")),
											[var_0_8("\xE28\x05\xE6ϧ>\xDC,\x03\xE4Ì=\xEC 3\xEAü.\xED\"", "[\x83Vl\x8B\xAE\xD3")] = ui.new_slider(var_0_8("\xD7\x1E\x99", "=\x9BK\xD8w"), "A", var_0_8(">\xA4\xBD1\x18\b\xD0\v\xBE\xBC(", "\xBDd\xCB\xD2\\8i"), 0, 100, 10)
										}
									},
									[var_0_8("\"X\xEE+", "HO1\x9D")] = {
										[var_0_8("\x9C\xB13", "\xDC\xE8\xD0Q")] = ui.new_combobox(var_0_8("ً\xC4", "\xC1\x95ޅPL:"), "A", var_0_8("\xE5UF\xDE\xC2\x1D\\\xD7\xCAXL\xC6\xC9O", "\xB2\xA6=/"), {
											var_0_8("\xDCF\xE7x\xCB2", "^\x9B*\x88\x1A\xAA"),
											var_0_8("\xA3>+\xB0", "\xD5\xE4_F")
										}),
										[var_0_8("-\xB7͆v&", "\x17Jۢ\xE4")] = {
											[var_0_8("8\xE2G\xBF/0\xF0C\x90(-\xF4G\xA9>", "[Y\x86&\xCF")] = ui.new_checkbox(var_0_8("h\xDB\xE9", "G$\x8E\xA8Vs\xB0"), "A", var_0_8("\xFE\xA5s\xAF\x17\xB7@L\x9F\xB2f\xAD\x02\xB8S", ")\xBF\xC1\x12\xDFc\xDE6")),
											[var_0_8("\xA0/\xCB&\xB9\xAA?", "\xCA\xCBF\xA7J")] = ui.new_checkbox(var_0_8("\x004\xFD", "\x11La\xBCS"), "A", var_0_8("\xAE.\xD5;#\x82R", "\xC3\xE5G\xB9WP\xE3+")),
											[var_0_8("\xE3\xF0\x01^\xFB\xE1\xFB", "\x8F\x80\x9C`0")] = ui.new_checkbox(var_0_8("\x94\xE4\xD1", "wر\x90r"), "A", var_0_8("\xEA%\xF8L\xDD(\xFE", "\"\xA9I\x99")),
											[var_0_8("\xAC\xED\x18\x9F\x95\xFF\x1C\x82\xBE\xEF\x03", "\xEBʌk")] = ui.new_checkbox(var_0_8(" A\x15", "\xA5l\x14TȉG\x97"), "A", var_0_8("\\\xB58\x9C:\xA7<\x81n\xB7#\xC82\xB5-\x9C\x7F\xA6k\x86{\xB0.\xC1", "\xE8\x1A\xD4K")),
											[var_0_8("1Ha\xFC\xC8;Hv\xEC\xF2%", "\x97W)\x12\x88")] = ui.new_checkbox(var_0_8("w\x9A\xEB", "\x9E;Ϫ\xB0"), "A", var_0_8("i_ ]\xCCC_7M\x89]", "\xEC/>S)"))
										},
										[var_0_8("\xFD\xA8->", "\xE2\x9A\xC9@[\xCA")] = {
											[var_0_8("\xC2F\x13\vE\xB0\xC4v\x1B\x11F\xA8\xC4[", "ܡ)}x*")] = ui.new_checkbox(var_0_8("\x90D\x81", "n\xDC\x11\xC0"), "A", var_0_8("Wv:\t\xE4;\xF4\xE7rp8\x0E\xEE%", "\xC7\x14\x19Tz\x8BW\x91")),
											[var_0_8("Q\x00ع\x16\xE5C\fё\x03", "\x8A'i\xBD\xCE{")] = ui.new_slider(var_0_8("32\xA8", "\x9F\x7Fg\xE9M\x93\x99\xAF"), "A", var_0_8("1\xF9\xE1\xBDM\xC4\x03\xF5\xE8\xEA\b\xD3N", "\xABg\x90\x84\xCA "), -100, 100, 0),
											[var_0_8("\x06&\xEC\x1B\x1D \xED\t\x1C\x10\xF0", "lpO\x89")] = ui.new_slider(var_0_8("\x13\xF7U", "U_\xA2\x14H\xCDa\x89"), "A", var_0_8("\xC1\xF4/\xCB\x00\xF7\xC9\xF2\xF1j\x94\x14\xB1", "\xAD\x97\x9DJ\xBCm\x98"), -100, 100, 0),
											[var_0_8("2\x01=\xCA\xD1[\xD1\xF6(7\"", "\x93DhX\xBD\xBC4\xB5")] = ui.new_slider(var_0_8("6\xBD\xAA", "\xB0z\xE8\xEB"), "A", var_0_8("\xB6|?X\xE3\x8Fq?C\xAE\xC8os", "\x8E\xE0\x15Z/"), -100, 100, 0),
											[var_0_8("u\xC77S\xA7\x9F\xBAf\xD53_\xAB", "\xE5\x14\xB4G6\xC4\xEB")] = ui.new_slider(var_0_8("\x05K\xE0", "\xE0I\x1E\xA1\x83\x95\xCA"), "A", var_0_8("\xD0\xF6\xE1U\xF2\xF1\xB1B\xF0\xF1\xF8_", "0\x91\x85\x91"), 0, 200, 0),
											[var_0_8("ND\xBC\xFC\xD5<_^\xA6\xE1\xDF\x13^E\xA6\xFA\xD0\"YI", "L:,Վ\xB1")] = ui.new_slider(var_0_8("\xE7\x113", "\x18\xABDrM"), "A", var_0_8("\xDB\x15Y@\x83\xCE\x01\xBF\xFC\x12^\x12\x83\xD7\x17\xB9\xEE\x13SW", "͏}02\xE7\xBEd"), 30, 200, 0),
											[var_0_8("Ҳ\x1A\x16\xE4\xF7\xE0\xAFΣ\x11", "¡\xC7te\x81\x83\xBF")] = ui.new_combobox(var_0_8("\xC0\x11\xE9", "\xC2\x8CD\xA8ȗ"), "A", var_0_8("q\xEE\xDB6\xF0V\xBB\xD8*\xF1G", "\x95\"\x9B\xB5E"), {
												var_0_8("'\xF4\xC6\xFB\x01\xF1\xD0\xFE", "\x9Ac\x9D\xB5"),
												var_0_8("\xA9\n\xEA\xA1\xF9\x81\x1B", "\x8C\xEDo\x8C\xC0"),
												var_0_8("/\x17k\x1D\x14\nx", "xfy\x1D")
											})
										}
									},
									[var_0_8("\xBF\xE6\xAD/\xA5\xED\xBE(", "[̃\xD9")] = {
										[var_0_8("\xC2\xF6F\xC0", "\x9E\xAE\x9F5\xB4ӽ")] = ui.new_listbox(var_0_8("~\xC8\xCC", "\xD52\x9D\x8D\xBD\x17"), "A", var_0_8("\xDD)\x8A\xA6{\xA3\xEB4\x85\xB4{\xAB\xF05", "ĞF\xE4\xC0\x12"), {}),
										[var_0_8("F^\x13K\xD5", "\xB9*?q.")] = ui.new_label(var_0_8("\xF8\xE8\x00", "{\xB4\xBDAY"), "A", var_0_8("\xEC\x89礊͂\xF6펂\x82\xF1錘", "\xE9\xA2쐄")),
										[var_0_8("\xBC\xC5\xF3\x1F", "?Ҥ\x9Ezٖ")] = ui.new_textbox(var_0_8("\x1F\xFE\xD7", "\x98S\xAB\x96\x8C)"), "A", var_0_8("\x81\xEA\x8D5\xDD\x1C7\x8C\xE4\x8E6", "h\xE2\x85\xE3S\xB4{"))
									}
								}
								local var_27_21 = {
									[var_0_8("\x02\x057Y\x02\x02.", "0ckC")] = {
										[var_0_8("ݩs\xD4$oשs\xC3", "\x1B\xBE\xC6\x1D\xB0M")] = ui.new_combobox(var_0_8("\xC3~\xDC", ".\x8F+\x9DT\xC9"), "A", var_0_8("vvB\xCB^\x1A\xC5\x17{Y\xCC[\x1A\xDC^wX\xD1", "\xA87\x186\xA2?s"), var_27_11.cache.antiaim.conditions),
										[var_0_8("\x18\xEC%\x92\xC0\xC7\x13\xFF\x1F\x83\xDD\xC0\x13\xF34\x89\xDD\xC0\x04", "\xAEw\x9A@\xE0\xB2")] = {},
										[var_0_8("(k\xCCw\x01\xA2\b", "\x84J\x1E\xA5\x1Be\xC7z")] = {}
									}
								}

								for iter_27_1 = 1, #var_27_11.cache.antiaim.conditions do
									var_27_21.antiaim.override_conditions[iter_27_1] = ui.new_checkbox(var_0_8("\x03\xD2\xDE", "\xD4O\x87\x9F\xC7\xC7\xD5"), "A", "[" .. var_27_11.cache.antiaim.conditions[iter_27_1] .. var_0_8("D\xE0\xF8\as\xC1\x1Dk\xB2\xBCCY\x97\vq\xA1\xA7BX\x97\v|\xB4\xA1NR\xD0\v", "x\x19\xC0\xD5'<\xB7"))
									var_27_21.antiaim.builder[iter_27_1] = {
										ui.new_combobox(var_0_8("4u\x1E", "(x _"), "A", "[" .. var_27_11.cache.antiaim.conditions[iter_27_1] .. var_0_8("\a\xEBt:\x96\x1E-\xEB*m\xA6\v9\xA3yw\xA0\x1B?", "\x7FZ\xCBY\x1A\xCF"), {
											var_0_8("\xF3:\xA1\xCE", "\x9D\xBDUϫi"),
											var_0_8("\xE9\xA7ަ\x06\xD2", "c\xA6\xC1\xB8\xD5"),
											var_0_8("\xF5\xB2\x8E\xAF\t\x98", "\xEA\xB6\xD7\xE0\xDBl"),
											var_0_8("섩%Ņ", "U\xA0\xE1\xDB")
										}),
										ui.new_combobox(var_0_8("p0\xA2", "+<e\xE3\xA9V\xBC"), "A", "[" .. var_27_11.cache.antiaim.conditions[iter_27_1] .. var_0_8("M\x88\x9C\xFFcͮws\xDD«U\xC1\xB0-u", "W\x10\xA8\xB1\xDF:\xAC\xD9"), {
											var_0_8("\x10\xC8_\xDC.8\xD9", "[T\xAD9\xBD"),
											var_0_8("1\xBD\x1A\xFD\xAE\xD5\x15\xBD", "\xB6p\xD9l\x9C\xC0")
										}),
										ui.new_slider(var_0_8("\x86=i", "\xEB\xCAh(\x8F"), "A", "[" .. var_27_11.cache.antiaim.conditions[iter_27_1] .. var_0_8("0\xCBV\xF94\x8A\f\xF9\f\x86\x14\xAC\x03\x9F", "\xD9m\xEB{"), -180, 180, 0),
										ui.new_slider(var_0_8("\v\xBC_", "\xDDG\xE9\x1E6\x10\xB0\xAD"), "A", "[" .. var_27_11.cache.antiaim.conditions[iter_27_1] .. var_0_8("\t\xBC\x13\xFF\r\xFDI\xFF2\xF5L\xAC \xBCM\xB60\xF9", "\xDFT\x9C>"), -180, 180, 0),
										ui.new_slider(var_0_8("\xFA\xC9\xC3", "[\xB6\x9C\x82\xBD\xD7"), "A", "[" .. var_27_11.cache.antiaim.conditions[iter_27_1] .. var_0_8("C3\xE1\x15Gr\xBB\x15mv\xAFZpw\xECFww\xA9", "5\x1E\x13\xCC"), -180, 180, 0),
										ui.new_slider(var_0_8("\xD5\xD5Q", "Ǚ\x80\x10\xE4"), "A", "[" .. var_27_11.cache.antiaim.conditions[iter_27_1] .. var_0_8("\xECj\xA8Y\x9E\xD0=\xA5\n\xB0\xD8>\xE6\x11\xE7\xD5/\xE9\x18\xBE", "ǱJ\x85y"), 10, 100, 0),
										ui.new_combobox(var_0_8("\x94\xFC\x9D", "JةܞW\xA6"), "A", "[" .. var_27_11.cache.antiaim.conditions[iter_27_1] .. var_0_8("\xD5c^l~\xED0\n\"Y\xA8.\x1C(_", ":\x88CsL"), {
											var_0_8("¾\xD9M\x8C#", "=\x91ʸ9\xE5@\xCB"),
											var_0_8("v[\x9DSY@", "'<2\xE9")
										}),
										ui.new_combobox(var_0_8("6\x06\x82", "\xC3zS\xC3L\xE2H\xD2"), "A", "[" .. var_27_11.cache.antiaim.conditions[iter_27_1] .. var_0_8("ٔv\xBE\x05\xE1\xC7\"\xF0\"\xA4\xC72\xFA$", "A\x84\xB4[\x9E"), {
											var_0_8(")y\xD7:", "Ne\x1C\xB1"),
											var_0_8("\x1F\xB1\xF2^", "1EԀ"),
											var_0_8("%\x05\xD7\xFA\xF5", "\x81wl\xB0\x92")
										}),
										ui.new_combobox(var_0_8("\x10\xFA&", "|\\\xAFg\xADEn"), "A", "[" .. var_27_11.cache.antiaim.conditions[iter_27_1] .. var_0_8("\xFCxNw\xE5=\x052\xCF+\n!\xC4x\x10#\xC0,\x06", "W\xA1Xc"), {
											var_0_8("6\xFC\xE9͢\xDC7", "Cr\x99\x8F\xACװ"),
											var_0_8("\x9F\xAE\xF9\x0F\xA7\xB1\xAE\x01\xB0", "n\xDE\xC2\x8E")
										}),
										ui.new_combobox(var_0_8(";\xEC:", "\xC1w\xB9{\xC92"), "A", "[" .. var_27_11.cache.antiaim.conditions[iter_27_1] .. var_0_8("JH\xB4f?p\vt\x00\xB9+\x00}\x1A", "\x7F\x17h\x99Fo\x19"), {
											var_0_8("-\b\xB1\xA1", "\xD3ig\xC6\xCFKL\xD7"),
											var_0_8("\xFB\xB7", "֮\xC7Џ\x1El\xDA"),
											var_0_8("+\x81\x19\xA5", ")q\xE4k\xCA\xC56\xB8"),
											var_0_8("H\x8C6Xu\x80", "<\x1A\xEDX"),
											var_0_8("\xFB?g\xF2\xA1\xD5", "θJ\x14\x86")
										}),
										ui.new_combobox(var_0_8("\x14\xD1\xCF", "\xACX\x84\x8Eѓ*X"), "A", "[" .. var_27_11.cache.antiaim.conditions[iter_27_1] .. var_0_8("\xBAʁM\x06\xFC\xAA\x84\x82\x8C\x1E!\xFC\xAA\x84\x82\x8C\x009\xF1\xBB", "\xDE\xE7\xEA\xACmV\x95"), {
											var_0_8("\xC7\xE6\xD4\f\xE8\xFD", "x\x8D\x8F\xA0"),
											var_0_8("l\xA9\xA4B", "2 \xCC\xD6")
										}),
										ui.new_slider(var_0_8("\xAAr\x14", "q\xE6'U\x19\xD3"), "A", "[" .. var_27_11.cache.antiaim.conditions[iter_27_1] .. var_0_8("\xE3\xFBK\xA8\x17¿H\xD6\xFB\x00\xE15ؿ\vͲ\x02\xED", "+\xBE\xDBf\x88G\xAB\xCB"), -89, 89, 0),
										ui.new_slider(var_0_8("\x0EK\x11", "9B\x1EP"), "A", "[" .. var_27_11.cache.antiaim.conditions[iter_27_1] .. var_0_8("\x14\x98\xEDU\xB40\xE0\x87!\x98\xB3\x10\x876\xFA\x80i˩\x11\x81", "\xE4I\xB8\xC0u\xE4Y\x94"), -89, 89, 0),
										ui.new_slider(var_0_8("\xE3\xBCT", "t\xAF\xE9\x15"), "A", "[" .. var_27_11.cache.antiaim.conditions[iter_27_1] .. var_0_8("ø\xF3\x06\xEB8+\xFD\xF0\xFEU\xCC8+\xFD\xF0\xFEB\xDE=>\xE7", "_\x9E\x98\xDE&\xBBQ"), 10, 100, 0),
										ui.new_combobox(var_0_8("Ԉ\x14", "\xA8\x98\xDDU\xD2\xC3"), "A", "[" .. var_27_11.cache.antiaim.conditions[iter_27_1] .. var_0_8("\x96\x9E\xB8ǒ\xDF\xE2Ǧ\xD1\xF1\x82\xE5", "\xE7˾\x95"), {
											var_0_8("\xE32\xED\xF4", "{\xAD]\x83\x91ܕ"),
											var_0_8("%\xCD\xE9$c\xF8\x0F\xD7", "\x99v\xA4\x8DA\x14"),
											var_0_8("\xDD\"\x8F\xEC", "`\x8ER悗"),
											var_0_8("i\xBF]U\xE5\xFCK", "\x8E/\xD0/\"\x84"),
											var_0_8("Ŀ\n\x06TQ", "<\x96\xDEdb;"),
											var_0_8("f)DBԷ", "Q%\\76\xBB\xDA")
										}),
										ui.new_combobox(var_0_8(",q\x8C", "\xE1`$\xCDW"), "A", "[" .. var_27_11.cache.antiaim.conditions[iter_27_1] .. var_0_8("\xD4\xE6\x0F9EN\x1E\xA9\xB5UphL\x01\xA9\xABM}y\x01", "i\x89\xC6\"\x19\x1C/"), {
											var_0_8(";\xA0Ub\xC5\x03", "\xA0q\xC9!\x16"),
											var_0_8("\xF8]\xBE\xB7", "ʹ8\xCC\xC7\xC9")
										}),
										ui.new_slider(var_0_8("\xAF\xEB\x1D", "x\xE3\xBE\\"), "A", "[" .. var_27_11.cache.antiaim.conditions[iter_27_1] .. var_0_8("\x00\x1CR;\x1A]΢;U\rh7\x1C\xCA\xEB9YQ", "\x82]<\x7F\x1BC<\xB9"), -360, 360, 0),
										ui.new_slider(var_0_8("d\a\x19", "\x1D(RX.\x80#"), "A", "[" .. var_27_11.cache.antiaim.conditions[iter_27_1] .. var_0_8("\x06\x05\x99]8\xB9,\x05\xC7\x18\x02\xB75A\x94\x0E\b\xBC>\v", "\xD8[%\xB4}a"), -360, 360, 0),
										ui.new_slider(var_0_8("\tC=", "7E\x16|\xA3"), "A", "[" .. var_27_11.cache.antiaim.conditions[iter_27_1] .. var_0_8("E\x93\x11\xA8\xE6pG\xB4k\xC4U\xFC\xDCy\x10\xF0}\xDF]\xF1\x91", "\x94\x18\xB3<\x88\xBF\x110"), 10, 100, 0)
									}
								end

								local function var_27_22()
									for iter_36_0 = 1, #var_27_11.cache.antiaim.conditions do
										for iter_36_1 = 1, #var_27_21.antiaim.builder[iter_36_0] do
											if iter_36_0 >= 1 then
												ui.set_visible(var_27_21.antiaim.override_conditions[iter_36_0], ui.get(var_27_20.tab) == var_0_8("\x93$\xED\xA9\xF7\xBB'", "\x96\xD2J\x99\xC0") and var_27_11.cache.antiaim.push_conditions[ui.get(var_27_21.antiaim.conditions)] > 1 and var_27_11.cache.antiaim.push_conditions[ui.get(var_27_21.antiaim.conditions)] == iter_36_0)
											end

											if iter_36_0 >= 1 and ui.get(var_27_20.tab) == var_0_8("\xC2\xC6,\x83ts\xB9", "ԃ\xA8X\xEA\x15\x1A") then
												local var_36_0 = 0
												local var_36_1

												while true do
													if var_36_0 == 2 then
														local var_36_2 = 0

														while true do
															if var_36_2 == 0 then
																ui.set_visible(var_27_21.antiaim.builder[iter_36_0][6], var_36_1 and ui.get(var_27_21.antiaim.builder[iter_36_0][1]) ~= var_0_8("ض\xDE\xE2", "#\x96ٰ\x87"))
																ui.set_visible(var_27_21.antiaim.builder[iter_36_0][7], var_36_1)

																var_36_2 = 1
															end

															if var_36_2 == 1 then
																ui.set_visible(var_27_21.antiaim.builder[iter_36_0][8], var_36_1 and ui.get(var_27_21.antiaim.builder[iter_36_0][7]) ~= var_0_8("\xD3Y\x1F\x18rQ", "\x16\x990kl\x17#"))

																var_36_0 = 3

																break
															end
														end
													end

													if var_36_0 == 6 then
														ui.set_visible(var_27_21.antiaim.builder[iter_36_0][18], var_36_1 and ui.get(var_27_21.antiaim.builder[iter_36_0][15]) == var_0_8("0*\xB0\x14A\xC2", "^s_\xC3`.\xAF") and ui.get(var_27_21.antiaim.builder[iter_36_0][9]) == var_0_8("bG(<7>\xC7\xEFM", "\x80#+_]NM\xE7"))
														ui.set_visible(var_27_21.antiaim.builder[iter_36_0][19], var_36_1 and ui.get(var_27_21.antiaim.builder[iter_36_0][15]) == var_0_8("\x87\b% \x18s", "\xC9\xC4}VTw\x1E") and ui.get(var_27_21.antiaim.builder[iter_36_0][9]) == var_0_8("\xE2\xE2\x13\xBE\xDA\xFDD\xB0\xCD", "ߣ\x8Ed"))

														break
													end

													if var_36_0 == 0 then
														var_36_1 = var_27_11.cache.antiaim.push_conditions[ui.get(var_27_21.antiaim.conditions)] == iter_36_0 and ui.get(var_27_21.antiaim.override_conditions[iter_36_0]) or var_27_11.cache.antiaim.push_conditions[ui.get(var_27_21.antiaim.conditions)] == 1 and var_27_11.cache.antiaim.push_conditions[ui.get(var_27_21.antiaim.conditions)] == iter_36_0 and not ui.get(var_27_21.antiaim.override_conditions[1])

														ui.set_visible(var_27_21.antiaim.builder[iter_36_0][iter_36_1], var_36_1)
														ui.set_visible(var_27_21.antiaim.builder[iter_36_0][2], var_36_1 and ui.get(var_27_21.antiaim.builder[iter_36_0][1]) ~= var_0_8("k{\x87\x89", "G%\x14\xE9\xECX"))

														var_36_0 = 1
													end

													if var_36_0 == 5 then
														ui.set_visible(var_27_21.antiaim.builder[iter_36_0][15], var_36_1 and ui.get(var_27_21.antiaim.builder[iter_36_0][9]) == var_0_8(".\xD1\a\xF1#\xDAO\xD2\x1E", "\xA9o\xBDp\x90Z"))
														ui.set_visible(var_27_21.antiaim.builder[iter_36_0][16], var_36_1 and ui.get(var_27_21.antiaim.builder[iter_36_0][15]) == var_0_8("\xEE\x966\xB9\xB0\x8D", "\xE2\xAD\xE3E\xCD\xDF\xE0i") and ui.get(var_27_21.antiaim.builder[iter_36_0][9]) == var_0_8("y25Z\xD6\b\x181,", "{8^B;\xAF"))
														ui.set_visible(var_27_21.antiaim.builder[iter_36_0][17], var_36_1 and ui.get(var_27_21.antiaim.builder[iter_36_0][15]) == var_0_8("\xD9V`\xF5\x15\xF3", "\xE1\x9A#\x13\x81z\x9E") and ui.get(var_27_21.antiaim.builder[iter_36_0][9]) == var_0_8("{\f\xFCV\xEC\xF4\x90;T", "T:`\x8B7\x95\x87\xB0"))

														var_36_0 = 6
													end

													if var_36_0 == 3 then
														ui.set_visible(var_27_21.antiaim.builder[iter_36_0][9], var_36_1)
														ui.set_visible(var_27_21.antiaim.builder[iter_36_0][10], var_36_1 and ui.get(var_27_21.antiaim.builder[iter_36_0][9]) == var_0_8("/\x89\xAC\x1Bff\x01\xE6\x00", "\x89n\xE5\xDBz\x1F\x15!"))
														ui.set_visible(var_27_21.antiaim.builder[iter_36_0][11], var_36_1 and ui.get(var_27_21.antiaim.builder[iter_36_0][10]) == var_0_8("9\xA8+o9F", "\x1Ez\xDDX\x1BV+D") and ui.get(var_27_21.antiaim.builder[iter_36_0][9]) == var_0_8("\x19$\xFC\x87!;\xAB\x896", "\xE6XH\x8B"))

														var_36_0 = 4
													end

													if var_36_0 == 1 then
														ui.set_visible(var_27_21.antiaim.builder[iter_36_0][3], var_36_1 and (ui.get(var_27_21.antiaim.builder[iter_36_0][2]) == var_0_8("\xE9C\xB6\x17U\xE0X", "<\xAD&\xD0v \x8C,") or ui.get(var_27_21.antiaim.builder[iter_36_0][1]) == var_0_8("o=\xEF\xD6", "\xAF!R\x81\xB3@")))
														ui.set_visible(var_27_21.antiaim.builder[iter_36_0][4], var_36_1 and ui.get(var_27_21.antiaim.builder[iter_36_0][2]) == var_0_8("\xCF\xEB&\xCE2\xB1\xEB\xEB", "Ҏ\x8FP\xAF\\") and ui.get(var_27_21.antiaim.builder[iter_36_0][1]) ~= var_0_8("\x97\xE6\xFD\xC3", "\xA6ى\x93"))
														ui.set_visible(var_27_21.antiaim.builder[iter_36_0][5], var_36_1 and ui.get(var_27_21.antiaim.builder[iter_36_0][2]) == var_0_8("§d\xA7\xFFE\xE6\xA7", "&\x83\xC3\x12Ƒ") and ui.get(var_27_21.antiaim.builder[iter_36_0][1]) ~= var_0_8("}\xD94\xEE", "43\xB6Z\x8BX"))

														var_36_0 = 2
													end

													if var_36_0 == 4 then
														ui.set_visible(var_27_21.antiaim.builder[iter_36_0][12], var_36_1 and ui.get(var_27_21.antiaim.builder[iter_36_0][10]) == var_0_8("Q\xA1\x05\x0F\f\x05", "8\x12\xD4v{ch") and ui.get(var_27_21.antiaim.builder[iter_36_0][9]) == var_0_8("?\xE5\xEF\xD2\xC6\xCD^\xE6\xF6", "\xBE~\x89\x98\xB3\xBF"))
														ui.set_visible(var_27_21.antiaim.builder[iter_36_0][13], var_36_1 and ui.get(var_27_21.antiaim.builder[iter_36_0][10]) == var_0_8("\v\x17aߥM", " Hb\x12\xAB\xCA") and ui.get(var_27_21.antiaim.builder[iter_36_0][9]) == var_0_8("%\x84%u\xEE\x17\xC8=z", "\x97d\xE8R\x14"))
														ui.set_visible(var_27_21.antiaim.builder[iter_36_0][14], var_36_1 and ui.get(var_27_21.antiaim.builder[iter_36_0][10]) == var_0_8("\\\xCC\xE5\x1Cp\xD4", "h\x1F\xB9\x96") and ui.get(var_27_21.antiaim.builder[iter_36_0][9]) == var_0_8("\xFD\xB5\xE4\xF6\xFEߠ\xCF\xD2", "\xA0\xBCٓ\x97\x87\xAC\x80"))

														var_36_0 = 5
													end
												end
											else
												ui.set_visible(var_27_21.antiaim.builder[iter_36_0][iter_36_1], false)
											end
										end
									end
								end

								local var_27_23 = {
									[var_0_8("\x80\x1F͵\xAB", "\xD8\xE2v\xA3\xD1")] = {
										{
											[var_0_8("\xBC\xF9\x15\x05", "_ސ{a7\x10")] = function()
												return var_27_8:is_doubletap()
											end,
											[var_0_8("\r\x81\xA2W", "\x83y\xE4\xDA#")] = var_0_8("\xFD\xDF7\x03u\x1E\xCD\xD12", "{\xB9\xB0Ba\x19")
										},
										{
											[var_0_8("\xCA\x06\x17U", "Q\xA8oy1uO8")] = function()
												return var_27_8:is_hideshots()
											end,
											[var_0_8("\xD3\x0F\xFD\xA2", "֧j\x85")] = var_0_8("\x066\f\\<p\xCDi9B[=2\xD8 5", "\xB9IX,/T\x1F")
										},
										{
											[var_0_8("\x8A\xDE\x14\xA4", "\x9F\xE8\xB7z\xC0\xB3")] = function()
												return ui.get(var_27_11.reference.exploits.fakeduck)
											end,
											[var_0_8("07\xB05", "ADR\xC8")] = var_0_8("\x01Eq+\x8F\xDF{ [2!\xDC\xDCw6D", "\x1EE0\x12@\xAF\xAF")
										},
										{
											[var_0_8("\xF2%\x11\xE8", "[\x90L\x7F\x8C")] = function()
												return ui.get(var_27_11.reference.rage.min_damage_override[2])
											end,
											[var_0_8("\xF4\r^5", "\xB0\x80h&A\xB3ڵ")] = var_0_8("\xF4\xC5\xCF\x14\xD7\xC1\x82\x1A\xC6\xC1\xD0\a\xD9\xC0\xC7", "u\xB0\xA4\xA2")
										},
										{
											[var_0_8("\x86\xCB\v\xF4", "\x19\xE4\xA2e\x90\xBA")] = function()
												return ui.get(var_27_11.reference.antiaim.slowwalk[2])
											end,
											[var_0_8("\\3\xA1\x1A", "\x84(V\xD9n\x92")] = var_0_8("M\xC7(\xAB\xE7~\xF3Jw\xC4)", ">\x1E\xABG\xDC\xC7\x13\x9C")
										},
										{
											[var_0_8("BL\xA22", "- %\xCCV=\xA9O")] = function()
												return ui.get(var_27_11.reference.misc.freestanding[2])
											end,
											[var_0_8("AP\x1D\xA8", "\x1C55e\xDC\xD5")] = var_0_8("+N\rDI\xB5Q\xD1\tU\x06F", "\xBFm<h!:\xC10")
										},
										{
											[var_0_8("\x85\xDE\x16\xE3", "\x87\xE7\xB7x")] = function()
												return ui.get(var_27_11.reference.misc.autopeek[2])
											end,
											[var_0_8("\xF2\x0FT\xF0", "Ɇj,\x84Uz")] = var_0_8("\a\x19~<\nL\xD8&3\a7>\x12\x1F\xC10\"", "CVl\x17_al\xA8")
										},
										{
											[var_0_8("\xA61B\x0E", "0\xC4X,j\xC4D\xB5")] = function()
												return ui.get(var_27_11.reference.rage.force_safe)
											end,
											[var_0_8("\x96\xDA\xC47", "L⿼C\xE0\xC4\xC2")] = var_0_8("\xFF'\x15\xF3\xF8\x99;\x06\xF6\xF8\xCD1", "\x9D\xB9Hg\x90")
										},
										{
											[var_0_8("[\xBA\x84~", "\xD19\xD3\xEA\x1A\xC8")] = function()
												return ui.get(var_27_11.reference.rage.force_body)
											end,
											[var_0_8("\x15˾\x95", "\xB2a\xAE\xC6\xE10")] = var_0_8("\xE9Y\x16\xF2}\xA6\r\xC0R\x1D", "o\xAF6d\x91\x18\x86")
										},
										{
											[var_0_8("A\x10.\x11", "u#y@")] = function()
												return ui.get(var_27_20.ragebot.exploits.airlag)
											end,
											[var_0_8("ɸ\xF6\xC2", "/\xBDݎ\xB6C")] = var_0_8("\x01\xB65\xC7I\xAE", "I@\xDFG\xAB(\xC9@")
										}
									},
									[var_0_8("\x03\x83\xC0P\xA3|\x1E\x82\xD6J", "\x1Dj\xED\xA49\xC0")] = {
										{
											[var_0_8("\xB8\xAA\xE3\xB3\xD6Ӵ\xFD\xA3", "\x92\xD1ćڵ\xB2\xC0")] = function()
												return var_27_8:is_doubletap()
											end,
											[var_0_8("95\x9B\x05", "\xC7MP\xE3q0")] = var_0_8(".0K\xCF&:J\xCC:", "\xADJ_>")
										},
										{
											[var_0_8("\xCF\x17X?\xC8\x06\xA8\xC9\v", "ܦy<V\xABg")] = function()
												return var_27_8:is_hideshots() and not var_27_8:is_doubletap()
											end,
											[var_0_8("\xFD\a%\xA4", "z\x89b]\xD0[\xAA")] = var_0_8("\x8F\xE8\x18Jƺ\xA6ޔ", "\xAA\xE7\x81|/\xB5\xD2\xC9")
										},
										{
											[var_0_8("\x82\xB5>9\t+\x9F\xB4(", "J\xEB\xDBZPj")] = function()
												return ui.get(var_27_11.reference.exploits.fakeduck)
											end,
											[var_0_8("X\xC6C/", "\x92,\xA3;[Z\x94\x1A")] = var_0_8("q8\xBB\x8A\x04e(\xBD\x8A", ")\x15M\xD8\xE1")
										},
										{
											[var_0_8("\x1DCvL\x17LfJ\x06", "%t-\x12")] = function()
												return ui.get(var_27_11.reference.rage.min_damage_override[2])
											end,
											[var_0_8("\xDB\xFAN\xB6", "˯\x9F6\xC2")] = var_0_8("\x7F\xCF\x14:]J", "\xA2\x1B\xAEy[:/")
										},
										{
											[var_0_8("\xDA\xCB\x1B\xFC<\xD8\xC7\xCA\r", "\xB9\xB3\xA5\x7F\x95_")] = function()
												return ui.get(var_27_11.reference.rage.force_safe)
											end,
											[var_0_8("Ep\xD7\xE0", "w1\x15\xAF\x94")] = var_0_8("D\xB4\x10X`Y\x85\xFCY\xA1", "\x957\xD5v=M)\xEA")
										},
										{
											[var_0_8("\x14\b\xCE\xCF\xEA8\xBB\x14\x0F", "{}f\xAA\xA6\x89Y\xCF")] = function()
												return ui.get(var_27_11.reference.rage.force_body)
											end,
											[var_0_8("Z\x05@)", "\xC9.`8]n\xE3")] = var_0_8("\xB9\f\xEA\xE0X\xC0\xB2\x0E", "\xA1\xDBc\x8E\x99u")
										},
										{
											[var_0_8("u\xBF\xA2z\xCE}\xA5\xA9a", "\xAD\x1C\xD1\xC6\x13")] = function()
												return ui.get(var_27_11.reference.misc.freestanding[2])
											end,
											[var_0_8("a鯯", "\xDB\x15\x8C\xD7")] = var_0_8("N\xAAâK\\\xB9ȣ", "8(ئ\xC7")
										}
									}
								}

								class(var_0_8("3\xA0\x1C#<", "OF\xD4u"))({
									[var_0_8("\xA4\x19\xEF\xD2\xF8\x04\xA9\x05", "m\xC7v\x81\xA6\x99")] = function(arg_54_0, arg_54_1, arg_54_2)
										local var_54_0 = 0
										local var_54_1

										while true do
											if var_54_0 == 0 then
												local var_54_2 = 0

												while true do
													if var_54_2 == 0 then
														local var_54_3 = 0

														while true do
															if var_54_3 == 0 then
																local var_54_4 = 0

																while true do
																	if var_54_4 == 0 then
																		for iter_54_0 = 1, #arg_54_1 do
																			if arg_54_1[iter_54_0] == arg_54_2 then
																				return true
																			end
																		end

																		return false
																	end
																end
															end
														end
													end
												end

												break
											end
										end
									end,
									[var_0_8("\"\xA4e", "\x96Q\xD0\x17")] = {
										[var_0_8("\xED\xCAߘ\xEC\xC7", "뙥\x80")] = function(arg_55_0, arg_55_1, arg_55_2)
											local var_55_0 = 0
											local var_55_1
											local var_55_2

											while true do
												if var_55_0 == 1 then
													while true do
														local var_55_3 = 0

														while true do
															if var_55_3 == 0 then
																if var_55_1 == 0 then
																	local var_55_4 = 0

																	while true do
																		if var_55_4 == 1 then
																			var_55_1 = 1

																			break
																		end

																		if var_55_4 == 0 then
																			var_55_2 = {}

																			for iter_55_0 in string.gmatch(arg_55_1, var_0_8("\xF3r\x9C", "\x9E\xDB)\xC2O&F\xCA") .. arg_55_2 .. var_0_8("~nf", "\xE8#EOb\x8E\xB6")) do
																				var_55_2[#var_55_2 + 1] = string.gsub(iter_55_0, "\n", "")
																			end

																			var_55_4 = 1
																		end
																	end
																end

																if var_55_1 == 1 then
																	return var_55_2
																end

																break
															end
														end
													end

													break
												end

												if var_55_0 == 0 then
													var_55_1 = 0
													var_55_2 = nil
													var_55_0 = 1
												end
											end
										end,
										[var_0_8("m\x0F \xFFv\x0F\x13", "\x9D\x19`\x7F")] = function(arg_56_0, arg_56_1)
											if arg_56_1 == var_0_8("\xB3\x91\xE0\x00", "Q\xC7\xE3\x95e0") or arg_56_1 == var_0_8("{S\xF7\x02\xF3", "\xDB\x1D2\x9Bq\x96\xE6\\") then
												return arg_56_1 == var_0_8("\xC52\xD0~", "-\xB1@\xA5\x1B\x9F(")
											else
												return arg_56_1
											end
										end,
										[var_0_8("\t\x190\xAD`\x1C\x12\x06\xAF|\t", "\x12}vo\xCA")] = function(arg_57_0, arg_57_1, arg_57_2, arg_57_3)
											local var_57_0 = 0
											local var_57_1
											local var_57_2
											local var_57_3
											local var_57_4
											local var_57_5
											local var_57_6
											local var_57_7
											local var_57_8

											while true do
												if var_57_0 == 1 then
													local var_57_9 = 0

													while true do
														if var_57_9 == 0 then
															var_57_3 = nil
															var_57_4 = nil
															var_57_9 = 1
														end

														if var_57_9 == 1 then
															var_57_0 = 2

															break
														end
													end
												end

												if var_57_0 == 4 then
													while true do
														local var_57_10 = 0

														while true do
															if var_57_10 == 0 then
																if var_57_1 == 2 then
																	for iter_57_0 = 1, var_57_3 do
																		local var_57_11 = 0
																		local var_57_12
																		local var_57_13

																		while true do
																			if var_57_11 == 1 then
																				while true do
																					if var_57_12 == 0 then
																						local var_57_14 = var_27_6(arg_57_1.x + var_57_4 * ((iter_57_0 + var_57_8 - 1) % var_57_3), arg_57_1.y + var_57_5 * ((iter_57_0 + var_57_8 - 1) % var_57_3), arg_57_1.z + var_57_6 * ((iter_57_0 + var_57_8 - 1) % var_57_3))

																						var_57_2 = var_57_2 .. ("\a%02x%02x%02x%02x%s"):format(var_57_14.x, var_57_14.y, var_57_14.z, 200, arg_57_3:sub(iter_57_0, iter_57_0))

																						break
																					end
																				end

																				break
																			end

																			if var_57_11 == 0 then
																				local var_57_15 = 0

																				while true do
																					if var_57_15 == 0 then
																						var_57_12 = 0

																						local var_57_16

																						var_57_15 = 1
																					end

																					if var_57_15 == 1 then
																						var_57_11 = 1

																						break
																					end
																				end
																			end
																		end
																	end

																	return var_57_2
																end

																if var_57_1 == 1 then
																	local var_57_17 = 0

																	while true do
																		if var_57_17 == 0 then
																			local var_57_18 = -(globals.realtime() * 10) % var_57_3

																			var_57_8 = math.floor(var_57_18)
																			var_57_17 = 1
																		end

																		if var_57_17 == 1 then
																			var_57_1 = 2

																			break
																		end
																	end
																end

																var_57_10 = 1
															end

															if var_57_10 == 1 then
																if var_57_1 == 0 then
																	local var_57_19 = 0

																	while true do
																		if var_57_19 == 1 then
																			var_57_1 = 1

																			break
																		end

																		if var_57_19 == 0 then
																			var_57_2, var_57_3 = "", #arg_57_3
																			var_57_4, var_57_5, var_57_6 = (arg_57_2.x - arg_57_1.x) / var_57_3, (arg_57_2.y - arg_57_1.y) / var_57_3, (arg_57_2.z - arg_57_1.z) / var_57_3
																			var_57_19 = 1
																		end
																	end
																end

																break
															end
														end
													end

													break
												end

												if var_57_0 == 3 then
													local var_57_20

													var_57_8 = nil
													var_57_0 = 4
												end

												if var_57_0 == 0 then
													var_57_1 = 0
													var_57_2 = nil
													var_57_0 = 1
												end

												if var_57_0 == 2 then
													var_57_5 = nil
													var_57_6 = nil
													var_57_0 = 3
												end
											end
										end
									},
									[var_0_8("]=M\xF2", "\x9B0\\9\x9APͧ")] = {
										[var_0_8("\xAFȸ\xECǿz\xB8ɿ", "%٭\xDBߘ\xCB")] = function(arg_58_0, arg_58_1, arg_58_2)
											return var_27_6(arg_58_1.x + arg_58_2.x, arg_58_1.y + arg_58_2.y, arg_58_1.z + arg_58_2.z)
										end,
										[var_0_8("\a\n\r;N\xA4\xFF\x13\x00 /N\xBF", "\x96ie\x7FV/\xC8")] = function(arg_59_0, arg_59_1)
											local var_59_0 = 0
											local var_59_1

											while true do
												if var_59_0 == 0 then
													local var_59_2 = 0

													while true do
														local var_59_3 = 0

														while true do
															if var_59_3 == 0 then
																if var_59_2 == 1 then
																	return arg_59_1
																end

																if var_59_2 == 0 then
																	local var_59_4 = 0

																	while true do
																		if var_59_4 == 1 then
																			var_59_2 = 1

																			break
																		end

																		if var_59_4 == 0 then
																			while arg_59_1 > 180 do
																				arg_59_1 = arg_59_1 - 360
																			end

																			while arg_59_1 < -180 do
																				arg_59_1 = arg_59_1 + 360
																			end

																			var_59_4 = 1
																		end
																	end
																end

																break
															end
														end
													end

													break
												end
											end
										end,
										[var_0_8("\xC8\xF3\xE0\xA1\xF8\xCC\xCB\xE0\xE3", "\xA0\xAE\x92\x93է")] = function(arg_60_0, arg_60_1, arg_60_2, arg_60_3)
											local var_60_0 = 1000
											local var_60_1 = math.floor(arg_60_1 * var_60_0)
											local var_60_2 = math.floor(arg_60_2 * var_60_0)
											local var_60_3 = math.floor(arg_60_3 * var_60_0)
											local var_60_4 = (var_60_1 + (var_60_2 - var_60_1) * var_60_3 / var_60_0) / var_60_0

											if var_60_4 > 0.8999999999999773 and arg_60_2 == 1 then
												return 1
											end

											if var_60_4 < 0.1 and arg_60_2 == 0 then
												return 0
											end

											return var_60_4
										end
									},
									[var_0_8("R\xE1\x14@\tS", "! \x84z$l")] = {
										[var_0_8("\xAD\x11j_", "\x1C\xD9t\x12+")] = function(arg_61_0, arg_61_1, arg_61_2, arg_61_3, arg_61_4, arg_61_5)
											renderer.text(arg_61_1.x, arg_61_1.y, arg_61_2.x, arg_61_2.y, arg_61_2.z, 200 * arg_61_3, arg_61_4, 0, arg_61_5)
										end,
										[var_0_8("\xC5^\xD8P߹", "\\\xB27\xB64\xB0\xCE")] = function(arg_62_0, arg_62_1, arg_62_2, arg_62_3, arg_62_4, arg_62_5, arg_62_6)
											local var_62_0 = 0
											local var_62_1
											local var_62_2

											while true do
												if var_62_0 == 3 then
													local var_62_3 = 8

													for iter_62_0 = 1, var_62_3 do
														local var_62_4 = 0
														local var_62_5
														local var_62_6

														while true do
															if var_62_4 == 1 then
																while true do
																	if var_62_5 == 0 then
																		var_62_6 = var_62_6 / 2

																		var_62_1(arg_62_1, var_27_6(arg_62_2.x - var_62_6, arg_62_2.y - var_62_6), var_27_6(arg_62_3.x + var_62_6 * 2, arg_62_3.y + var_62_6 * 2), var_27_6(arg_62_4.x, arg_62_4.y, arg_62_4.z), 4.5 * (var_62_3 - var_62_6 * 2) * arg_62_5)

																		break
																	end
																end

																break
															end

															if var_62_4 == 0 then
																local var_62_7 = 0

																while true do
																	if var_62_7 == 0 then
																		var_62_5 = 0
																		var_62_6 = nil
																		var_62_7 = 1
																	end

																	if var_62_7 == 1 then
																		var_62_4 = 1

																		break
																	end
																end
															end
														end
													end

													break
												end

												if var_62_0 == 0 then
													local var_62_8 = 0
													local var_62_9

													while true do
														if var_62_8 == 0 then
															local var_62_10 = 0

															while true do
																if var_62_10 == 0 then
																	if arg_62_5 >= 1 then
																		arg_62_5 = 1
																	end

																	arg_62_1 = arg_62_6 and arg_62_1 or 0
																	var_62_10 = 1
																end

																if var_62_10 == 1 then
																	var_62_0 = 1

																	break
																end
															end

															break
														end
													end
												end

												if var_62_0 == 2 then
													local var_62_11 = 0

													while true do
														if var_62_11 == 1 then
															var_62_0 = 3

															break
														end

														if var_62_11 == 0 then
															if arg_62_6 then
																renderer.rectangle(arg_62_2.x + arg_62_1, arg_62_2.y + 3, 1, arg_62_3.y - 6, 255, 255, 255, 100 * arg_62_5)
															end

															function var_62_1(arg_63_0, arg_63_1, arg_63_2, arg_63_3, arg_63_4)
																local var_63_0 = 0
																local var_63_1
																local var_63_2
																local var_63_3
																local var_63_4
																local var_63_5

																while true do
																	if var_63_0 == 1 then
																		var_63_3 = nil
																		var_63_4 = nil
																		var_63_0 = 2
																	end

																	if var_63_0 == 0 then
																		var_63_1 = 0
																		var_63_2 = nil
																		var_63_0 = 1
																	end

																	if var_63_0 == 2 then
																		local var_63_6

																		while true do
																			if var_63_1 == 1 then
																				local var_63_7 = 0
																				local var_63_8

																				while true do
																					if var_63_7 == 0 then
																						local var_63_9 = 0

																						while true do
																							if var_63_9 == 0 then
																								renderer.line(var_63_2, var_63_3, var_63_2, var_63_6, arg_63_3.x, arg_63_3.y, arg_63_3.z, arg_63_4)
																								renderer.line(var_63_2, var_63_3, var_63_4, var_63_3, arg_63_3.x, arg_63_3.y, arg_63_3.z, arg_63_4)

																								var_63_9 = 1
																							end

																							if var_63_9 == 1 then
																								var_63_1 = 2

																								break
																							end
																						end

																						break
																					end
																				end
																			end

																			if var_63_1 == 2 then
																				renderer.line(var_63_4, var_63_3, var_63_4, var_63_6, arg_63_3.x, arg_63_3.y, arg_63_3.z, arg_63_4)
																				renderer.line(var_63_2, var_63_6, var_63_4, var_63_6, arg_63_3.x, arg_63_3.y, arg_63_3.z, arg_63_4)

																				break
																			end

																			if var_63_1 == 0 then
																				local var_63_10 = 0

																				while true do
																					if var_63_10 == 0 then
																						var_63_2, var_63_3 = arg_63_1.x - arg_63_0, arg_63_1.y
																						var_63_4, var_63_6 = var_63_2 + arg_63_2.x, var_63_3 + arg_63_2.y
																						var_63_10 = 1
																					end

																					if var_63_10 == 1 then
																						var_63_1 = 1

																						break
																					end
																				end
																			end
																		end

																		break
																	end
																end
															end

															var_62_11 = 1
														end
													end
												end

												if var_62_0 == 1 then
													local var_62_12 = 0

													while true do
														if var_62_12 == 0 then
															renderer.blur(arg_62_2.x - arg_62_1, arg_62_2.y, arg_62_3.x, arg_62_3.y, 0.5, 0.5 * arg_62_5)
															renderer.rectangle(arg_62_2.x - arg_62_1, arg_62_2.y, arg_62_3.x, arg_62_3.y, 10, 10, 10, 175 * arg_62_5)

															var_62_12 = 1
														end

														if var_62_12 == 1 then
															var_62_0 = 2

															break
														end
													end
												end
											end
										end,
										[var_0_8("\x18:i*I1", "uzU\x11")] = function(arg_64_0, arg_64_1, arg_64_2, arg_64_3, arg_64_4)
											local var_64_0 = arg_64_2:lerp(arg_64_3, 0.33000001)
											local var_64_1 = utilz.math:vec3_t_add(var_27_6(entity.get_prop(arg_64_1, var_0_8("\x85\xD0<A\xA5\xF0\x81\xE19", "\xBD\xE8\x8FJ$\xC6"))), var_64_0)
											local var_64_2 = utilz.math:vec3_t_add(var_27_6(entity.get_prop(arg_64_1, var_0_8("\xF1\x95\x1CK\xD4'\xFD\xB2\x19", "j\x9C\xCAj.\xB7"))), var_64_0)
											local var_64_3 = {
												{
													var_64_1.x,
													var_64_1.y,
													var_64_1.z
												},
												{
													var_64_1.x,
													var_64_2.y,
													var_64_1.z
												},
												{
													var_64_2.x,
													var_64_2.y,
													var_64_1.z
												},
												{
													var_64_2.x,
													var_64_1.y,
													var_64_1.z
												},
												{
													var_64_1.x,
													var_64_1.y,
													var_64_2.z
												},
												{
													var_64_1.x,
													var_64_2.y,
													var_64_2.z
												},
												{
													var_64_2.x,
													var_64_2.y,
													var_64_2.z
												},
												{
													var_64_2.x,
													var_64_1.y,
													var_64_2.z
												}
											}
											local var_64_4 = {
												{
													0,
													1
												},
												{
													1,
													2
												},
												{
													2,
													3
												},
												{
													3,
													0
												},
												{
													5,
													6
												},
												{
													6,
													7
												},
												{
													1,
													4
												},
												{
													4,
													8
												},
												{
													0,
													4
												},
												{
													1,
													5
												},
												{
													2,
													6
												},
												{
													3,
													7
												},
												{
													5,
													8
												},
												{
													7,
													8
												},
												{
													3,
													4
												}
											}

											for iter_64_0 = 1, #var_64_4 do
												if var_64_3[var_64_4[iter_64_0][1]] ~= nil and var_64_3[var_64_4[iter_64_0][2]] ~= nil then
													local var_64_5 = 0
													local var_64_6
													local var_64_7
													local var_64_8

													while true do
														if var_64_5 == 0 then
															var_64_6 = 0
															var_64_7 = nil
															var_64_5 = 1
														end

														if var_64_5 == 1 then
															local var_64_9

															while true do
																if var_64_6 == 1 then
																	if var_64_7.x ~= 0 and var_64_7.y ~= 0 and var_64_9.x ~= 0 and var_64_9.y ~= 0 then
																		renderer.line(var_64_7.x, var_64_7.y, var_64_9.x, var_64_9.y, arg_64_4.x, arg_64_4.y, arg_64_4.z, 100)
																	end

																	break
																end

																if var_64_6 == 0 then
																	var_64_7 = var_27_6(renderer.world_to_screen(var_64_3[var_64_4[iter_64_0][1]][1], var_64_3[var_64_4[iter_64_0][1]][2], var_64_3[var_64_4[iter_64_0][1]][3]))
																	var_64_9 = var_27_6(renderer.world_to_screen(var_64_3[var_64_4[iter_64_0][2]][1], var_64_3[var_64_4[iter_64_0][2]][2], var_64_3[var_64_4[iter_64_0][2]][3]))
																	var_64_6 = 1
																end
															end

															break
														end
													end
												end
											end
										end
									}
								})
								class(var_0_8("-\x15z*//", "J]y\x1BS"))({
									[var_0_8("t\xA8\xD9h|\xB7\xEFz", "\x1E\x1Dۆ")] = function(arg_65_0, arg_65_1)
										return arg_65_1 and entity.is_alive(arg_65_1) and entity.get_player_weapon(arg_65_1)
									end,
									[var_0_8("G\xA2\n\xFF\xE0`\x1D\x00A\xAE\r\xE3", "n5\xC7y\x9A\x94?x")] = function(arg_66_0, arg_66_1)
										arg_66_1 = arg_66_1 and nil
									end,
									[var_0_8("\x06\x1F\xEB\x00J\xF5\f\x0F\xF3>M\xF9\x05%\xF0-P\xFB\b\x14", "\x9Caz\x9F_9")] = function(arg_67_0, arg_67_1, arg_67_2, arg_67_3, arg_67_4)
										local var_67_0 = math.abs(var_27_11.cvar.sv_gravity) * globals.tickinterval()
										local var_67_1 = math.abs(var_27_11.cvar.sv_jump_impulse) * globals.tickinterval()
										local var_67_2 = arg_67_2
										local var_67_3 = arg_67_2
										local var_67_4 = var_27_6(entity.get_prop(arg_67_1, var_0_8("É\xCC\xFD\b#=݀\xDF\xF4\x04\x016گ", "_\xAEֺ\x98kb")))

										if not (var_67_4.z > 0) or not -var_67_0 then
											local var_67_5 = var_67_1
										end

										for iter_67_0 = 1, arg_67_4 do
											local var_67_6 = 0
											local var_67_7
											local var_67_8

											while true do
												if var_67_6 == 0 then
													var_67_3 = var_67_2
													var_67_2 = utilz.math:vec3_t_add(var_67_2, var_67_4 * globals.tickinterval())
													var_67_6 = 1
												end

												if var_67_6 == 1 then
													local var_67_9, var_67_10 = client.trace_line(0, var_67_3.x, var_67_3.y, var_67_3.z, var_67_2.x, var_67_2.y, var_67_2.z)
													local var_67_11 = var_67_10

													if var_67_9 <= 0.9900000000000091 then
														return var_67_3
													end

													break
												end
											end
										end

										return var_67_2
									end,
									[var_0_8("\x8A\x1Bc\x99\x16ȝ1b\x9F\x12Ҍ", "\xA6\xE9n\x11\xEBs")] = function(arg_68_0)
										local var_68_0 = 0
										local var_68_1
										local var_68_2
										local var_68_3
										local var_68_4

										while true do
											if var_68_0 == 2 then
												while true do
													local var_68_5 = 0

													while true do
														if var_68_5 == 0 then
															if var_68_1 == 1 then
																local var_68_6 = 0

																while true do
																	if var_68_6 == 0 then
																		if var_27_11.cache.antiaim.ground_ticks > 2 then
																			local var_68_7 = 0

																			while true do
																				if var_68_7 == 0 then
																					local var_68_8 = 0

																					while true do
																						if var_68_8 == 0 then
																							if var_68_4.standing and not var_68_4.in_air then
																								var_68_2 = ui.get(var_27_21.antiaim.override_conditions[2]) and 2 or 1
																							end

																							if var_68_4.walking and not var_68_4.in_air then
																								var_68_2 = ui.get(var_27_21.antiaim.override_conditions[3]) and 3 or 1
																							end

																							var_68_8 = 1
																						end

																						if var_68_8 == 1 then
																							var_68_7 = 1

																							break
																						end
																					end
																				end

																				if var_68_7 == 2 then
																					local var_68_9 = 0
																					local var_68_10

																					while true do
																						if var_68_9 == 0 then
																							local var_68_11 = 0

																							while true do
																								if var_68_11 == 0 then
																									if var_68_4.ducking and var_68_4.standing and not var_68_4.in_air then
																										var_68_2 = ui.get(var_27_21.antiaim.override_conditions[6]) and 6 or 1
																									end

																									if var_68_4.ducking and not var_68_4.standing and not var_68_4.in_air then
																										var_68_2 = ui.get(var_27_21.antiaim.override_conditions[7]) and 7 or 1
																									end

																									var_68_11 = 1
																								end

																								if var_68_11 == 1 then
																									var_68_7 = 3

																									break
																								end
																							end

																							break
																						end
																					end
																				end

																				if var_68_7 == 3 then
																					if ui.get(var_27_11.reference.misc.autopeek[2]) then
																						var_68_2 = ui.get(var_27_21.antiaim.override_conditions[10]) and 10 or 1
																					end

																					break
																				end

																				if var_68_7 == 1 then
																					local var_68_12 = 0

																					while true do
																						if var_68_12 == 1 then
																							var_68_7 = 2

																							break
																						end

																						if var_68_12 == 0 then
																							if var_68_4.walking and ui.get(var_27_11.reference.antiaim.slowwalk[2]) and not var_68_4.in_air then
																								var_68_2 = ui.get(var_27_21.antiaim.override_conditions[4]) and 4 or 1
																							end

																							if var_68_4.running and not var_68_4.in_air then
																								var_68_2 = ui.get(var_27_21.antiaim.override_conditions[5]) and 5 or 1
																							end

																							var_68_12 = 1
																						end
																					end
																				end
																			end
																		else
																			local var_68_13 = 0
																			local var_68_14

																			while true do
																				if var_68_13 == 0 then
																					local var_68_15 = 0

																					while true do
																						if var_68_15 == 0 then
																							if var_68_4.in_air then
																								var_68_2 = ui.get(var_27_21.antiaim.override_conditions[8]) and 8 or 1
																							end

																							if var_68_4.air_ducking then
																								var_68_2 = ui.get(var_27_21.antiaim.override_conditions[9]) and 9 or 1
																							end

																							break
																						end
																					end

																					break
																				end
																			end
																		end

																		return var_68_2
																	end
																end
															end

															if var_68_1 == 0 then
																local var_68_16 = 0
																local var_68_17

																while true do
																	if var_68_16 == 0 then
																		local var_68_18 = 0

																		while true do
																			if var_68_18 == 0 then
																				local var_68_19

																				var_68_2, var_68_19 = 1, var_27_6(entity.get_prop(var_27_11.local_player, var_0_8("u1\xD2\xC4\xF1\x9F~k8\xC1\xCD\xFD\xBDul\x17", "\x1C\x18n\xA4\xA1\x92\xDE"))):length2d()
																				var_68_4 = {
																					[var_0_8("H\xD7W+_\xCAX\"", "E;\xA36")] = var_68_19 <= 5,
																					[var_0_8("\xA7\xA9\xC6A:ñ", "\xD6\xD0Ȫ*S\xAD")] = var_68_19 > 5 and var_68_19 <= 135,
																					[var_0_8("\xCB4|\xAE|\xD7&", "\x15\xB9A\x12\xC0")] = var_68_19 > 135,
																					[var_0_8("\xF7Xb\x1A\xA8\xEC", "\xC1\x9E6={")] = entity.get_prop(var_27_11.local_player, var_0_8("8.&\x9F9\x10'\xAA", "\xD9Uq@")) == 256,
																					[var_0_8("J\x06\xDE\xFF\xEB\x97\xE6@\x06\xC2\xC7", "\x85+o\xAC\xA0\x8F\xE2")] = entity.get_prop(var_27_11.local_player, var_0_8("ƜV\xF7\xCCʤC", "\xA0\xAB\xC30\xB1")) == 262 and entity.get_prop(var_27_11.local_player, var_0_8("\xDE<p!xԬ\xCC\xF2\x0Ey8R\xD5", "\xA7\xB3c\x16M<\xA1\xCF")) > 0.10000000000002274,
																					[var_0_8("\x05j\x88SE\x0Fx", ",a\x1F\xEB8")] = var_0_11.band(entity.get_prop(var_27_11.local_player, var_0_8("\xFC1\xFE\x82\xFD\x0F\xFF\xB7", "đn\x98")), 1) == 1 and entity.get_prop(var_27_11.local_player, var_0_8("U\x11\xF8\xFE|;\xFD\xF9y#\xF1\xE7V:", "\x928N\x9E")) > 0.1
																				}
																				var_68_18 = 1
																			end

																			if var_68_18 == 1 then
																				var_68_1 = 1

																				break
																			end
																		end

																		break
																	end
																end
															end

															break
														end
													end
												end

												break
											end

											if var_68_0 == 0 then
												var_68_1 = 0
												var_68_2 = nil
												var_68_0 = 1
											end

											if var_68_0 == 1 then
												local var_68_20 = 0

												while true do
													if var_68_20 == 1 then
														var_68_0 = 2

														break
													end

													if var_68_20 == 0 then
														local var_68_21

														var_68_4 = nil
														var_68_20 = 1
													end
												end
											end
										end
									end,
									[var_0_8("*\xDE[\xD9I$\xD6Z\xEA[9\xD2@\xE8e9\xD2B\xE3", ":M\xBB/\x86")] = function(arg_69_0, arg_69_1)
										local var_69_0 = 0
										local var_69_1
										local var_69_2

										while true do
											if var_69_0 == 1 then
												while true do
													if var_69_1 == 0 then
														local var_69_3 = var_27_11.native.get_client_entity(arg_69_1)

														if var_69_3 then
															do return entity.get_prop(arg_69_1, var_0_8("\x1F\n\xA7\v\xD6'Y\v\x1E4\xB5\x0E\xEA `\x17\x1F0", "~rU\xC1g\x85N4")), var_27_7.cast(var_0_8("\xC2\xD7=yБ", "\x18\xA4\xBBR"), var_27_7.cast(var_0_8("\xE4\xD3R\xBE\xE1\xE5\xC8c\xBE", "\x91\x91\xBA<\xCA"), var_69_3) + 620)[0] end

															break
														end

														do return 0 end

														break
													end
												end

												break
											end

											if var_69_0 == 0 then
												var_69_1 = 0

												local var_69_4

												var_69_0 = 1
											end
										end
									end,
									[var_0_8("\xE1\xD5';\xE5\xD8<\x0F\xE3\xD4\f\x14\xE7\xD38\x01\xF2\xC3", "d\x86\xB0S")] = function(arg_70_0, arg_70_1)
										local var_70_0 = 0
										local var_70_1
										local var_70_2
										local var_70_3

										while true do
											if var_70_0 == 1 then
												return var_27_10(toticks(var_70_2 - var_70_3), 0, var_70_1)
											end

											if var_70_0 == 0 then
												var_70_1 = globals.tickinterval() and math.floor(1 / globals.tickinterval()) / 2 - 1 or 0
												var_70_2, var_70_3 = arg_70_0:get_simulation_time(arg_70_1)
												var_70_0 = 1
											end
										end
									end,
									[var_0_8("\xDD\xC4V\x82\xBA\x1B\xD5\xCE", "u\xB3\xA1\"\xDD\xD3")] = {
										[var_0_8("Y\xB1\xE8\xC1\x01\xEB\x9AD\xBE\xFC\xC9", "\xC5-К\xA6d\x9F")] = {
											[var_0_8(",\xFA\x92\xB5'0", "SI\x94\xE6\xDC")] = nil,
											[var_0_8("7\xCA\xF5\xEBЈ>\xD0\xE3\xEE\xFB", "\xE9S\xBF\x96\x80\x8F")] = 0,
											[var_0_8("\xFB\x89\xD8w\x1FȄ\xC0v\x14ȟ\xCEe", "m\x97\xE6\xAF\x12")] = 0,
											[var_0_8("\xA5\xE3D{\x81\xAE\xFDMA\x93", "\xE0\xC0\x9A!$")] = var_27_6(),
											[var_0_8("\x8DQ\f\xBD\x8CF\x11\x85\x8AZ", "\xE2\xE34x")] = var_27_6(),
											[var_0_8("\x04\xE9\xFF\x9B\\\xBA۶\x06\xE2\xF8\xBD", "\xD9e\x8B\x8C\xC4*߷")] = var_27_6(),
											[var_0_8("\x12\n\xAE\x16P\x12", "$zo\xCFz")] = 0,
											[var_0_8("\x0F\x00볽", "Tlh\x84\xD8\xD8")] = 0,
											[var_0_8("\xC5\x15\xF9\\\xEF\xB6O\xCD\x15\xD2", "\"\xAC{\xA68\x80\xC4")] = false,
											[var_0_8("\xA2\xA5\xA9\xCCY", "t\xC4\xC9ȫ*\x13\xB5")] = 0,
											[var_0_8("e\x8F\xF6H\x19\x01\bs\x82\xC4R\a\t\x1B\x7F\x88", "|\x16\xE6\x9B=u`")] = var_27_6()
										},
										[var_0_8("է\xE7\xF2\xFB\xFF\xE6\xFA\xA2\xE8\xED\xF1", "\x95\xA5ˆ\x8B\x9E\x8D")] = {},
										[var_0_8("0\xA3L*6\xAFT", "FS\xCC ")] = function(arg_71_0)
											arg_71_0.players_info = {}

											for iter_71_0 = 1, globals.maxplayers() do
												if iter_71_0 ~= entity.get_local_player() and player:is_valid(iter_71_0) and entity.is_enemy(iter_71_0) then
													local var_71_0 = 0
													local var_71_1
													local var_71_2
													local var_71_3
													local var_71_4

													while true do
														if var_71_0 == 1 then
															local var_71_5
															local var_71_6

															var_71_0 = 2
														end

														if var_71_0 == 2 then
															while true do
																if var_71_1 == 1 then
																	local var_71_7 = {
																		[var_0_8("\xF0c\xDE:\x0F\xC5\xC9\xFBc\xD3%", "\xA4\x94\x16\xBDQP\xA4")] = entity.get_prop(iter_71_0, var_0_8("\xBF\xBFq\xBF\x03^t\xB9\xA1z\xBC2Ec", "\x17\xD2\xE0\x17\xD3G+")),
																		[var_0_8("\xA5\x89\a\xB2G\x14\xDE\xFF\xAD\x9F/\xAET<", "\x90\xC9\xE6p\xD75K\xBC")] = entity.get_prop(iter_71_0, var_0_8("X\xFA\x1F\xE6ڪB\xC0\v\xC8\xF9\xA1L\xFC\x18\xFD¤G\xC2\x1C\xFE", "\xC55\xA5y\x8A\x96")),
																		[var_0_8("\xE8\xC6\xDC\x1F\xEC\xD1\xDE,\xE8\xCC", "@\x8D\xBF\xB9")] = var_27_6(entity.get_prop(iter_71_0, var_0_8("\x0Eձ\xD4\xF0\xEC\xBF\x06˾\xDD\xFB̵", "\xC6c\x8Aк\x97\xA9"))),
																		[var_0_8("\x03\xF0\x97a\x02\xE7\x8AY\x04\xFB", ">m\x95\xE3")] = var_71_2,
																		[var_0_8("\xF2\x8A\x9A\xEB\x16\xF6\x84\x86\xD7\t\xE7\x91", "`\x93\xE8\xE9\xB4")] = var_27_6(entity.get_prop(iter_71_0, var_0_8("%\a\fN\x8E\x18*+,N\x816+1\x0ER", "YHXz+\xED"))),
																		[var_0_8("$\xBE\xA4:\x0F$", "{L\xDB\xC5V")] = entity.get_prop(iter_71_0, var_0_8("U\xE7\x1C$\xEB>T\xCC\x1D", "_8\xB8ul\x8E")),
																		[var_0_8("\xF3\xCA)\xE7\xF5", "\x8C\x90\xA2F")] = player:get_choked_packets(iter_71_0),
																		[var_0_8("\xD9&fv\xE1\xC2%X|\xFA", "\x8E\xB0H9\x12")] = entity.is_dormant(iter_71_0),
																		[var_0_8("\xA0=\x11#\xB5", "D\xC6Qp")] = entity.get_prop(iter_71_0, var_0_8("\xBA0\xB62@\x1C\xB0\x1C", "}\xD7o\xD0t,")),
																		[var_0_8("\x14NB\xE6t]\x13BK\xCCwN\x0E@F\xFD", "<g'/\x93\x18")] = player:get_simulated_origin(iter_71_0, var_71_2, entity.get_prop(iter_71_0, var_0_8("\xE15\xF1\xA6\xDA\xF2I\xFF", ".\x8Cj\x97ඓ")), player:get_choked_packets(iter_71_0))
																	}

																	arg_71_0.players_info[iter_71_0] = var_71_7

																	break
																end

																if var_71_1 == 0 then
																	local var_71_8 = 0

																	while true do
																		if var_71_8 == 0 then
																			local var_71_9

																			var_71_2, var_71_9 = var_27_6(entity.get_origin(iter_71_0)), var_27_6(entity.get_prop(iter_71_0, var_0_8("\x03\xBE\x1D\x85\r\xAF\x0E\x94\x19\x8E\x19\x8B!\x93\x02\x87\a\x8F", "\xE0n\xE1k")))

																			if var_71_2.x == 0 and var_71_2.y == 0 and var_71_2.z == 0 then
																				var_71_2 = var_71_9
																			end

																			var_71_8 = 1
																		end

																		if var_71_8 == 1 then
																			var_71_1 = 1

																			break
																		end
																	end
																end
															end

															break
														end

														if var_71_0 == 0 then
															var_71_1 = 0
															var_71_2 = nil
															var_71_0 = 1
														end
													end
												end
											end
										end,
										[var_0_8("\xF9(nG\xFF", "\"\x8BM\x1D")] = function(arg_72_0)
											local var_72_0 = 0
											local var_72_1

											while true do
												if var_72_0 == 0 then
													local var_72_2 = 0

													while true do
														if var_72_2 == 0 then
															arg_72_0.players_info = {}
															arg_72_0.target_info = {
																[var_0_8("\xB5\xFE\t]=\xA9", "IА}4")] = nil,
																[var_0_8(".\xF9\x89\xC0\xF8\x11^\xC4?\xE2\x9E", "\xABJ\x8Cꫧp3")] = 0,
																[var_0_8("#\x01[Z\xE3\x92-\x01HFδ.\x19", "\xCDOn,?\x91")] = 0,
																[var_0_8("\xA2F:\xF7\xB5\x05\xA3\x10\xA2L", "|\xC7?_\xA8\xD4k\xC4")] = var_27_6(),
																[var_0_8("\b\xADG\x05\xAB\xE5\x80\xF4\x0F\xA6", "\x93f\xC83Zė\xE9")] = var_27_6(),
																[var_0_8(":\xF2\xFC\xF2\xA8\xE574\xF3\xE6٧", "[[\x90\x8F\xADހ")] = var_27_6(),
																[var_0_8("+\xA5M]\xBFF", ".C\xC0,1\xCB")] = 0,
																[var_0_8("\a\xDE!\xA9!", "ed\xB6N\xC2D\xC4")] = 0,
																[var_0_8("AF\x0F\xF1\x82Yu\xD4F\\", "\xB5((P\x95\xED+\x18")] = false,
																[var_0_8("\x13\xBE$5\xA9", "ru\xD2ER\xDA*")] = 0,
																[var_0_8("W\xDFUf\xA0E\xC2]w\x93K\xC4Qt\xA5J", "\xCC$\xB68\x13")] = var_27_6()
															}

															break
														end
													end

													break
												end
											end
										end,
										[var_0_8("\xFA_ӑx", "r\x89+\xBC\xE3\x1DX")] = function(arg_73_0)
											for iter_73_0, iter_73_1 in pairs(arg_73_0.players_info) do
												if player:is_valid(iter_73_0) then
													local var_73_0 = 0
													local var_73_1

													while true do
														if var_73_0 == 0 then
															local var_73_2 = 0

															while true do
																if var_73_2 == 2 then
																	arg_73_0.target_info.in_dormant = iter_73_1.in_dormant
																	arg_73_0.target_info.flags = iter_73_1.flags
																	arg_73_0.target_info.simulated_origin = iter_73_1.simulated_origin

																	break
																end

																if var_73_2 == 0 then
																	local var_73_3 = 0
																	local var_73_4

																	while true do
																		if var_73_3 == 0 then
																			local var_73_5 = 0

																			while true do
																				if var_73_5 == 0 then
																					arg_73_0.target_info.entity = iter_73_0
																					arg_73_0.target_info.duck_amount = iter_73_1.duck_amount
																					var_73_5 = 1
																				end

																				if var_73_5 == 1 then
																					arg_73_0.target_info.lower_body_yaw = iter_73_1.lower_body_yaw
																					arg_73_0.target_info.eye_angles = iter_73_1.eye_angles
																					var_73_5 = 2
																				end

																				if var_73_5 == 2 then
																					var_73_2 = 1

																					break
																				end
																			end

																			break
																		end
																	end
																end

																if var_73_2 == 1 then
																	local var_73_6 = 0

																	while true do
																		if var_73_6 == 0 then
																			arg_73_0.target_info.net_origin = iter_73_1.net_origin
																			arg_73_0.target_info.abs_velocity = iter_73_1.abs_velocity
																			var_73_6 = 1
																		end

																		if var_73_6 == 2 then
																			var_73_2 = 2

																			break
																		end

																		if var_73_6 == 1 then
																			arg_73_0.target_info.health = iter_73_1.health
																			arg_73_0.target_info.choke = iter_73_1.choke
																			var_73_6 = 2
																		end
																	end
																end
															end

															break
														end
													end
												end
											end
										end
									}
								})

								local var_27_24 = {
									[var_0_8("\xE7\x0F\xAD\x11\xF0\x18", "p\x84}\xC8")] = ui.new_button(var_0_8("э\xD2", "\x95\x9Dؓ\x13:"), "A", var_0_8("\xEA\x94\x1D\xC9݃X\xCBƈ\x1E\xC1\xCE", "\xA8\xA9\xE6x"), function()
										writefile(var_0_21(ui.get(var_27_20.settings.name) .. var_0_8("Å\x9D\a\xF9\x9F\x97\x03\xF3\x83\x81Y蕐", "w\x9C\xED\xE4")), var_0_8("\xD3\xD0\x13jƑ\x03q\xCD\xD7\ty\x83\xD8\x0E>\xC5\xD8\f{", "\x1E\xA3\xB1`"))
									end),
									[var_0_8("\x1E%Y\x8C).", "\xB4z@5\xE9]K")] = ui.new_button(var_0_8("\xFA\"2", "]\xB6ws"), "A", var_0_8("\xA6\x1A߉\xA3\xFB\xC2\x1C܂\xB1\xF7\x85", "\x9E\xE2\x7F\xB3\xEC\xD7"), function()
										var_27_11.filesystem.remove_file(var_27_19 .. "/" .. var_27_11.cfg.get()[ui.get(var_27_20.settings.list) + 1], var_27_11.cfg.get()[ui.get(var_27_20.settings.list) + 1])
									end),
									[var_0_8("\xE2\xC1\xDF\xD3", "\xB6\x91\xA0\xA9")] = ui.new_button(var_0_8("\x15\x15\x11", "oY@Pv\xC7"), "A", var_0_8("\x8C\xB6\x18C\xFF\xB4\x01H\xB9\xBE\t", "&\xDF\xD7n"), function()
										local var_76_0 = 0
										local var_76_1
										local var_76_2
										local var_76_3

										while true do
											if var_76_0 == 2 then
												for iter_76_0 = 1, 10 do
													var_76_3(iter_76_0)
												end

												var_27_11.libs.clipboard.set(var_27_11.libs.base64.encode(var_76_1, var_0_8("\xAA2\xA8V\x93\xFC", "\xA5\xC8S\xDB3")))

												var_76_0 = 3
											end

											if var_76_0 == 1 then
												function var_76_3(arg_77_0)
													for iter_77_0 = 1, 19 do
														var_76_1 = var_76_1 .. var_0_21(ui.get(var_27_21.antiaim.builder[arg_77_0][iter_77_0])) .. "|"
													end
												end

												var_76_2()

												var_76_0 = 2
											end

											if var_76_0 == 3 then
												database.write(var_0_8("\xCF\xF3d~æ\xA8\xEB\xC9\xEF", "\x84\xA7\x8A\x14\x1B\xB1\xD5\xDC"), var_27_11.libs.base64.encode(var_76_1, var_0_8("\xF0\xD4\xF0Ij\xA6", "\\\x92\xB5\x83,")))
												writefile(var_27_11.cfg.get()[ui.get(var_27_20.settings.list) + 1], database.read(var_0_8("C\xE7Q\x83\xACS\x03\xD2E\xFB", "\xBD+\x9E!\xE6\xDE w")))

												break
											end

											if var_76_0 == 0 then
												local var_76_4 = 0

												while true do
													if var_76_4 == 1 then
														var_76_0 = 1

														break
													end

													if var_76_4 == 0 then
														var_76_1 = ""

														function var_76_2()
															for iter_78_0 = 2, 10 do
																var_76_1 = var_76_1 .. var_0_21(ui.get(var_27_21.antiaim.override_conditions[iter_78_0]) and var_0_8("J\xC9\x19\xC0", "\xCB>\xBBl\xA5") or var_0_8("\xFFuD-t", "\xB0\x99\x14(^\x11\x9E")) .. "|"
															end
														end

														var_76_4 = 1
													end
												end
											end
										end
									end),
									[var_0_8("R\xCFLU", "\xE8>\xA0-1")] = ui.new_button(var_0_8("X\xE6\xD4", "\xC1\x14\xB3\x95\xCC"), "A", var_0_8("\xFB\x0E\x80Ɨ\x02\x8E\xCC\xD1\b\x86", "\xA2\xB7a\xE1"), function()
										local var_79_0 = utilz.str:to_sub(var_27_11.libs.base64.decode(readfile(var_27_11.cfg.get()[ui.get(var_27_20.settings.list) + 1]), var_0_8("+\xC4\xF7\xF2J\xB6", "\xC1I\xA5\x84\x97|\x82")), "|")

										ui.set(var_27_21.antiaim.override_conditions[2], utilz.str:to_bool(var_79_0[1]))
										ui.set(var_27_21.antiaim.override_conditions[3], utilz.str:to_bool(var_79_0[2]))
										ui.set(var_27_21.antiaim.override_conditions[4], utilz.str:to_bool(var_79_0[3]))
										ui.set(var_27_21.antiaim.override_conditions[5], utilz.str:to_bool(var_79_0[4]))
										ui.set(var_27_21.antiaim.override_conditions[6], utilz.str:to_bool(var_79_0[5]))
										ui.set(var_27_21.antiaim.override_conditions[7], utilz.str:to_bool(var_79_0[6]))
										ui.set(var_27_21.antiaim.override_conditions[8], utilz.str:to_bool(var_79_0[7]))
										ui.set(var_27_21.antiaim.override_conditions[9], utilz.str:to_bool(var_79_0[8]))
										ui.set(var_27_21.antiaim.override_conditions[10], utilz.str:to_bool(var_79_0[9]))
										ui.set(var_27_21.antiaim.builder[1][1], var_79_0[10])
										ui.set(var_27_21.antiaim.builder[1][2], var_79_0[11])
										ui.set(var_27_21.antiaim.builder[1][3], tonumber(var_79_0[12]))
										ui.set(var_27_21.antiaim.builder[1][4], tonumber(var_79_0[13]))
										ui.set(var_27_21.antiaim.builder[1][5], tonumber(var_79_0[14]))
										ui.set(var_27_21.antiaim.builder[1][6], tonumber(var_79_0[15]))
										ui.set(var_27_21.antiaim.builder[1][7], var_79_0[16])
										ui.set(var_27_21.antiaim.builder[1][8], var_79_0[17])
										ui.set(var_27_21.antiaim.builder[1][9], var_79_0[18])
										ui.set(var_27_21.antiaim.builder[1][10], var_79_0[19])
										ui.set(var_27_21.antiaim.builder[1][11], var_79_0[20])
										ui.set(var_27_21.antiaim.builder[1][12], tonumber(var_79_0[21]))
										ui.set(var_27_21.antiaim.builder[1][13], tonumber(var_79_0[22]))
										ui.set(var_27_21.antiaim.builder[1][14], tonumber(var_79_0[23]))
										ui.set(var_27_21.antiaim.builder[1][15], var_79_0[24])
										ui.set(var_27_21.antiaim.builder[1][16], var_79_0[25])
										ui.set(var_27_21.antiaim.builder[1][17], tonumber(var_79_0[26]))
										ui.set(var_27_21.antiaim.builder[1][18], tonumber(var_79_0[27]))
										ui.set(var_27_21.antiaim.builder[1][19], tonumber(var_79_0[28]))

										for iter_79_0 = 2, 10 do
											local var_79_1 = 0

											while true do
												if var_79_1 == 1 then
													ui.set(var_27_21.antiaim.builder[iter_79_0][5], tonumber(var_79_0[(iter_79_0 - 1) * 19 + 14]))
													ui.set(var_27_21.antiaim.builder[iter_79_0][6], tonumber(var_79_0[(iter_79_0 - 1) * 19 + 15]))
													ui.set(var_27_21.antiaim.builder[iter_79_0][7], var_79_0[(iter_79_0 - 1) * 19 + 3 + 13])
													ui.set(var_27_21.antiaim.builder[iter_79_0][8], var_79_0[(iter_79_0 - 1) * 19 + 17 + 0])

													var_79_1 = 2
												end

												if var_79_1 == 0 then
													ui.set(var_27_21.antiaim.builder[iter_79_0][1], var_79_0[(iter_79_0 - 1) * 19 + 10])
													ui.set(var_27_21.antiaim.builder[iter_79_0][2], var_79_0[(iter_79_0 - 1) * 19 + 11])
													ui.set(var_27_21.antiaim.builder[iter_79_0][3], tonumber(var_79_0[(iter_79_0 - 1) * 19 + 12]))
													ui.set(var_27_21.antiaim.builder[iter_79_0][4], tonumber(var_79_0[(iter_79_0 - 1) * 19 + 13]))

													var_79_1 = 1
												end

												if var_79_1 == 3 then
													ui.set(var_27_21.antiaim.builder[iter_79_0][13], tonumber(var_79_0[(iter_79_0 - 1) * 19 + 22]))
													ui.set(var_27_21.antiaim.builder[iter_79_0][14], tonumber(var_79_0[(iter_79_0 - 1) * 19 + 23]))
													ui.set(var_27_21.antiaim.builder[iter_79_0][15], var_79_0[(iter_79_0 - 1) * 19 + 24])
													ui.set(var_27_21.antiaim.builder[iter_79_0][16], var_79_0[(iter_79_0 - 1) * 19 + 11 + 14])

													var_79_1 = 4
												end

												if var_79_1 == 2 then
													ui.set(var_27_21.antiaim.builder[iter_79_0][9], var_79_0[(iter_79_0 - 1) * 19 + 18])
													ui.set(var_27_21.antiaim.builder[iter_79_0][10], var_79_0[(iter_79_0 - 1) * 19 + 19])
													ui.set(var_27_21.antiaim.builder[iter_79_0][11], var_79_0[(iter_79_0 - 1) * 19 + 20])
													ui.set(var_27_21.antiaim.builder[iter_79_0][12], tonumber(var_79_0[(iter_79_0 - 1) * 19 + 11 + 10]))

													var_79_1 = 3
												end

												if var_79_1 == 4 then
													ui.set(var_27_21.antiaim.builder[iter_79_0][17], tonumber(var_79_0[(iter_79_0 - 1) * 19 + 26]))
													ui.set(var_27_21.antiaim.builder[iter_79_0][18], tonumber(var_79_0[(iter_79_0 - 1) * 19 + 27]))
													ui.set(var_27_21.antiaim.builder[iter_79_0][19], tonumber(var_79_0[(iter_79_0 - 1) * 19 + 28]))

													break
												end
											end
										end
									end)
								}

								local function var_27_25()
									if not ui.is_menu_open() then
										local var_80_0 = 0

										while true do
											if var_80_0 == 0 then
												local var_80_1 = 0

												while true do
													if var_80_1 == 0 then
														if ui.get(var_27_20.auto_home) then
															ui.set(var_27_20.tab, var_0_8("\xC5ͤ^", "֭\xA2\xC9;\xD6"))
														end

														return
													end
												end
											end
										end
									end

									local var_80_2 = ui.get(var_27_20.tab) == var_0_8("\vv\xA7D", "@C\x19\xCA!\xB7")
									local var_80_3 = ui.get(var_27_20.tab) == var_0_8("\xDB\xEFv\xB9,\xDDW", "#\x89\x8E\x11\xDCN\xB2")
									local var_80_4 = ui.get(var_27_20.tab) == var_0_8("\f@1\b,G(", "aM.E")
									local var_80_5 = ui.get(var_27_20.tab) == var_0_8("\xE9\xD6\x13\xB0\xDE\xD3\x13", "ſ\xBF`")
									local var_80_6 = ui.get(var_27_20.tab) == var_0_8("\xE7 \xFEM", "-\xAAI\x8D.8\x88")
									local var_80_7 = ui.get(var_27_20.tab) == var_0_8("\xB2\n\xD9\xF1\xA6\x89\x00\x92", "g\xE1o\xAD\x85\xCF\xE7")
									local var_80_8 = utilz:contains(ui.get(var_27_20.visuals.screen.windows), var_0_8("{\x85\xE1P^\x89\xF4GG", "5,\xE4\x95")) or utilz:contains(ui.get(var_27_20.visuals.screen.windows), var_0_8("\xE6\xDE\"\a\xC2*\xC9\xC8", "D\xAD\xBB[e\xAB")) or utilz:contains(ui.get(var_27_20.visuals.screen.windows), var_0_8("\xD0\x00\x15\xD4", "\xB9\x9Cor\xA7)\xE2\x1D"))
									local var_80_9 = utilz:contains(ui.get(var_27_20.visuals.screen.indicators), var_0_8("(\x00\x184\xB1\xF1", "\x83kev@\xD4")) or utilz:contains(ui.get(var_27_20.visuals.screen.indicators), var_0_8("\xE5\xD7!*@\xC5", "\xA9\xA1\xB6LK'\xA0"))

									var_27_22()
									ui.set_visible(var_27_11.reference.exploits.fakelag_type, ui.get(var_27_20.ragebot.exploits.fakelag) == var_0_8("\xFD[\xA4\x8A\x19.\xAD\xDD", "ȹ2\xD7\xEB{B"))
									ui.set_visible(var_27_11.reference.exploits.fakelag_variance, ui.get(var_27_20.ragebot.exploits.fakelag) == var_0_8("ֈ\xCA\xE3\x88z\x1F\xF6", "z\x92Ṃ\xEA\x16"))
									ui.set_visible(var_27_11.reference.exploits.fakelag_amount, ui.get(var_27_20.ragebot.exploits.fakelag) == var_0_8("\x9D\xEB\xD3\xCE\xED\xB7\xBC\xE6", "\xDBق\xA0\xAF\x8F"))

									local var_80_10 = {
										{
											var_27_21.antiaim.conditions,
											var_80_4
										},
										{
											var_27_20.username,
											var_80_2
										},
										{
											var_27_20.update_time,
											var_80_2
										},
										{
											var_27_20.build_state,
											var_80_2
										},
										{
											var_27_20.discord,
											var_80_2
										},
										{
											var_27_20.auto_home,
											var_80_2
										},
										{
											var_27_20.ragebot.tab,
											var_80_3
										},
										{
											var_27_20.ragebot.weapon.type,
											var_80_3 and ui.get(var_27_20.ragebot.tab) == var_0_8("\t\xB9C-1\xB2", "]^\xDC\"")
										},
										{
											var_27_20.ragebot.weapon.label,
											var_80_3 and ui.get(var_27_20.ragebot.tab) == var_0_8("8\xCD\xC0\x9A\xD5\xF9", "\x9Do\xA8\xA1꺗")
										},
										{
											var_27_20.ragebot.exploits.label,
											var_80_3 and ui.get(var_27_20.ragebot.tab) == var_0_8("^Xe=Ͱ\xA6\x96", "\xE5\x1B \x15Q\xA2\xD9\xD2")
										},
										{
											var_27_20.ragebot.exploits.extend_peek,
											var_80_3 and ui.get(var_27_20.ragebot.tab) == var_0_8("\t\xD4\xEB6E%\xD8\xE8", "*L\xAC\x9BZ")
										},
										{
											var_27_20.ragebot.exploits.reduce_register_shot_delay,
											var_80_3 and ui.get(var_27_20.ragebot.tab) == var_0_8("ו\x91%\x0F\xFB\x99\x92", "`\x92\xED\xE1I")
										},
										{
											var_27_20.ragebot.exploits.fakelag,
											var_80_3 and ui.get(var_27_20.ragebot.tab) == var_0_8("\xCDf\x18\xE4Fs\xB6\xFB", "\xC2\x88\x1Eh\x88)\x1A")
										},
										{
											var_27_20.ragebot.exploits.fakelag_amount,
											var_80_3 and ui.get(var_27_20.ragebot.tab) == var_0_8("\xF9\xCE\x13D\x1B\xB9\xBD<", "O\xBC\xB6c(t\xD0\xC9") and ui.get(var_27_20.ragebot.exploits.fakelag) ~= var_0_8("Y\xCA9@!3x\xC7", "_\x1D\xA3J!C")
										},
										{
											var_27_20.ragebot.exploits.allow_unsafe_charge,
											var_80_3 and ui.get(var_27_20.ragebot.tab) == var_0_8("Y*P;p\x83\x10o", "d\x1CR W\x1F\xEA")
										},
										{
											var_27_20.ragebot.exploits.airlag,
											var_80_3 and ui.get(var_27_20.ragebot.tab) == var_0_8("\x14J\xF0}\xF4\xDF\xFC-", "^Q2\x80\x11\x9B\xB6\x88")
										},
										{
											var_27_20.antiaim.safety,
											var_80_4
										},
										{
											var_27_20.visuals.tab,
											var_80_5
										},
										{
											var_27_20.visuals.screen.windows,
											var_80_5 and ui.get(var_27_20.visuals.tab) == var_0_8("\xB8?\xF6<\xE7\xBA", "\xE7\xEB\\\x84Y\x82\xD4|")
										},
										{
											var_27_20.visuals.screen.windows_theme,
											var_80_5 and ui.get(var_27_20.visuals.tab) == var_0_8("ͷ\xE6:\xD4K", "%\x9EԔ_\xB1") and var_80_8
										},
										{
											var_27_20.visuals.screen.indicators,
											var_80_5 and ui.get(var_27_20.visuals.tab) == var_0_8("G\x1F\xB6\x82\bz", "m\x14|\xC4\xE7")
										},
										{
											var_27_20.visuals.screen.indicators_theme,
											var_80_5 and ui.get(var_27_20.visuals.tab) == var_0_8("\x93\xBEf\xA04.", "@\xC0\xDD\x14\xC5Q") and var_80_9
										},
										{
											var_27_20.visuals.world.last_shot_marker,
											var_80_5 and ui.get(var_27_20.visuals.tab) == var_0_8("\x98\xF9\xF0\xAE\xA3", "\xC7ϖ\x82\xC2")
										},
										{
											var_27_20.visuals.world.snapline,
											var_80_5 and ui.get(var_27_20.visuals.tab) == var_0_8("\x82Ei\xE4G", "#\xD5*\x1B\x88")
										},
										{
											var_27_20.visuals.world.defensive_box,
											var_80_5 and ui.get(var_27_20.visuals.tab) == var_0_8("\x97\x88)\xB3\xDC", "\x92\xC0\xE7[߸")
										},
										{
											var_27_20.visuals.world.last_seen_box,
											var_80_5 and ui.get(var_27_20.visuals.tab) == var_0_8("m\xFE\xE4%\xD5", "n:\x91\x96I\xB1\xD4g")
										},
										{
											var_27_20.visuals.world.adaptive_fov,
											var_80_5 and ui.get(var_27_20.visuals.tab) == var_0_8("\xC3;\xD8\xFEO", "\x89\x94T\xAA\x92+\xAB")
										},
										{
											var_27_20.visuals.world.adaptive_fov_amount,
											var_80_5 and ui.get(var_27_20.visuals.tab) == var_0_8("6\xD0m\xF1s", "\x17a\xBF\x1F\x9D") and ui.get(var_27_20.visuals.world.adaptive_fov)
										},
										{
											var_27_20.visuals.world.animate_zoom_fov,
											var_80_5 and ui.get(var_27_20.visuals.tab) == var_0_8("\xB1\x8D\x15\t\xD9", "R\xE6\xE2ge\xBD")
										},
										{
											var_27_20.visuals.world.animate_zoom_fov_amount,
											var_80_5 and ui.get(var_27_20.visuals.tab) == var_0_8("\xBC%\xA1\xBD\x10", "t\xEBJ\xD3\xD1") and ui.get(var_27_20.visuals.world.animate_zoom_fov)
										},
										{
											var_27_20.misc.tab,
											var_80_6
										},
										{
											var_27_20.misc.global.adaptive_strafe,
											var_80_6 and ui.get(var_27_20.misc.tab) == var_0_8("\x0F0\xD1')0", "EH\\\xBE")
										},
										{
											var_27_20.misc.global.killsay,
											var_80_6 and ui.get(var_27_20.misc.tab) == var_0_8("\x117\xEB֪\xA4", "\xD7V[\x84\xB4\xCB\xC8v")
										},
										{
											var_27_20.misc.global.clantag,
											var_80_6 and ui.get(var_27_20.misc.tab) == var_0_8("\x14\xE2\x89\xD12\xE2", "\xB3S\x8E\xE6")
										},
										{
											var_27_20.misc.global.fast_switch,
											var_80_6 and ui.get(var_27_20.misc.tab) == var_0_8("\xFD#\xF278\x13", "\xBF\xBAO\x9DUY\x7F\x97")
										},
										{
											var_27_20.misc.global.fast_ladder,
											var_80_6 and ui.get(var_27_20.misc.tab) == var_0_8("\xD1v\xAB̅I", "%\x96\x1AĮ\xE4")
										},
										{
											var_27_20.misc.game.console_filter,
											var_80_6 and ui.get(var_27_20.misc.tab) == var_0_8("\xEE\xF1\xBFP", "驐\xD25W")
										},
										{
											var_27_20.misc.game.viewmodel_x,
											var_80_6 and ui.get(var_27_20.misc.tab) == var_0_8("\x05G\xE0\xD9", "\xBCB&\x8D")
										},
										{
											var_27_20.misc.game.viewmodel_y,
											var_80_6 and ui.get(var_27_20.misc.tab) == var_0_8("\xC6Q\x004", "\xA8\x810mQ\x13\"h")
										},
										{
											var_27_20.misc.game.viewmodel_z,
											var_80_6 and ui.get(var_27_20.misc.tab) == var_0_8("P\x15\x015", "\x99\x17tlP\xBFE\xDB")
										},
										{
											var_27_20.misc.game.aspect_ratio,
											var_80_6 and ui.get(var_27_20.misc.tab) == var_0_8("n\x1E\xF0\xDD", "\x16)\x7F\x9D\xB8\x98\xEB")
										},
										{
											var_27_20.misc.game.thirdperson_distance,
											var_80_6 and ui.get(var_27_20.misc.tab) == var_0_8("0\xC6\xEC\xCF", "\xAAw\xA7\x81")
										},
										{
											var_27_20.misc.game.sunset_mode,
											var_80_6 and ui.get(var_27_20.misc.tab) == var_0_8("\xFD\xF1\xB1v", ">\xBA\x90\xDC\x13\xE3")
										},
										{
											var_27_20.settings.list,
											var_80_7
										},
										{
											var_27_20.settings.label,
											var_80_7
										},
										{
											var_27_20.settings.name,
											var_80_7
										},
										{
											var_27_24.create,
											var_80_7
										},
										{
											var_27_24.delete,
											var_80_7
										},
										{
											var_27_24.save,
											var_80_7
										},
										{
											var_27_24.load,
											var_80_7
										}
									}

									for iter_80_0, iter_80_1 in ipairs(var_80_10) do
										ui.set_visible(iter_80_1[1], iter_80_1[2])
									end

									ui.update(var_27_20.settings.list, var_27_11.cfg.update())
								end

								class(var_0_8("\xAC\xFD\xE5\xD8", "\xB6\xC1\x9C\x8C"))({
									[var_0_8("\xD3M\x11\xB7\xE40\xD5", "_\xA1,v҆")] = {
										[var_0_8("\xE3X\x03\x01u\xDF\xF1\xBD", "Ά sm\x1A\xB6\x85")] = {
											[var_0_8("5\xF0\xC0\x18Xb\"\xF1\xC2\x16O", "=V\x98\xAFs=")] = 0,
											[var_0_8("\xBD\x04\xD1 \xEE\x82+Ȣ\x04", "\xA7\xC9a\xBCP\xB1\xE1C")] = 0,
											[var_0_8("^\x1D\x88\xBC\xF9\xBEM\a\x91\xA1\xE8\x84\\", "\xE1.h\xE4Ϝ")] = 0,
											[var_0_8("\xBAտ]2l\xA1\xAB\xABԶ", "\xDFʠ\xD3.W3\xD2")] = var_0_8("\xDE\xE0\x1D|", "m\xB6\x89z\x14"),
											[var_0_8("W\xB1\x06\xFF\xEE\xD3\xD5lW\xAC\x19", "\x1C2\xC9r\x9A\x80\xB7\x8A")] = function(arg_81_0, arg_81_1)
												if not ui.get(var_27_20.ragebot.exploits.extend_peek) then
													return
												end

												local var_81_0 = cvar.sv_maxusrcmdprocessticks

												if not ui.get(var_27_11.reference.misc.autopeek[2]) or not var_27_8:is_doubletap() then
													local var_81_1 = 0
													local var_81_2

													while true do
														if var_81_1 == 0 then
															local var_81_3 = 0

															while true do
																if var_81_3 == 0 then
																	if var_81_0:get_string() ~= var_0_8("\xFB\xD0", "\x92\xCA\xE6y") then
																		var_81_0:set_string(var_0_8("\xBF\xB9", "^\x8E\x8F\x8E~\xA7\xD2\xC0"))
																	end

																	return
																end
															end

															break
														end
													end
												end

												if var_27_8:in_recharge() or arg_81_1.in_attack == 1 then
													local var_81_4 = 0
													local var_81_5

													while true do
														if var_81_4 == 0 then
															local var_81_6 = 0

															while true do
																if var_81_6 == 0 then
																	arg_81_1.no_choke = arg_81_1.chokedcommands ~= 0

																	if var_81_0:get_string() == var_0_8("Q\x93", "\xA7`\xA5}\x81") then
																		var_81_0:set_string(var_0_8("V\x81", "\xE8g\xB6v&\"F+"))
																	end

																	break
																end
															end

															break
														end
													end
												elseif var_81_0:get_string() ~= var_0_8("d\x01", "\x11U7O\x83P") then
													var_81_0:set_string(var_0_8("\x99\xD3", "_\xA8\xE5\xD9\xCC"))
												end
											end,
											[var_0_8("\x8C:\x8D\x8C\x86:\x81\xB6\x874\x82\x80\x8C2\x83\x9B", "\xE9\xEA[\xE6")] = function(arg_82_0, arg_82_1)
												local var_82_0 = 0
												local var_82_1
												local var_82_2
												local var_82_3

												while true do
													if var_82_0 == 0 then
														if ui.get(var_27_20.ragebot.exploits.fakelag) == var_0_8("uH\x91r\xA5]D\x86", "\xC71!\xE2\x13") then
															return
														end

														var_82_1 = ui.get(var_27_20.ragebot.exploits.fakelag_amount)
														var_82_0 = 1
													end

													if var_82_0 == 1 then
														ui.set(var_27_11.reference.exploits.fakelag_type, var_0_8("\x7FZ[\x16\xCAGV", "\xA72;#\x7F"))
														ui.set(var_27_11.reference.exploits.fakelag_variance, 0)

														var_82_0 = 2
													end

													if var_82_0 == 2 then
														var_82_2 = var_27_6(entity.get_prop(var_27_11.local_player, var_0_8("E,D\xE9\xABi\x11AڭD\x1CQ\xE5\xBCQ", "\xC8(s2\x8C")))
														var_82_3 = var_82_2:length2d()
														var_82_0 = 3
													end

													if var_82_0 == 3 then
														if ui.get(var_27_20.ragebot.exploits.fakelag) == var_0_8("\xD5!b\x1C\xE7,c\x1A", "\x7F\x93M\x17") then
															local var_82_4 = 0
															local var_82_5
															local var_82_6

															while true do
																if var_82_4 == 1 then
																	while true do
																		if var_82_5 == 0 then
																			local var_82_7 = math.random(4, 8)

																			if arg_82_0.pulse_state == var_0_8("\x83\xEF\xF2|", "\x10놕\x14") then
																				local var_82_8 = 0

																				while true do
																					if var_82_8 == 0 then
																						arg_82_0.temp_choke, arg_82_0.pulse_counter = var_82_1, arg_82_0.pulse_counter + 1 + 0

																						if arg_82_0.pulse_counter >= 40 - var_82_7 then
																							arg_82_0.pulse_state, arg_82_0.pulse_counter = var_0_8("\xD6DY", "l\xBA+.\xC6l\xE7"), 0
																						end

																						break
																					end
																				end

																				break
																			end

																			if arg_82_0.pulse_state == var_0_8(">\xB0\xE2", "\x1CRߕa") then
																				local var_82_9 = 0

																				while true do
																					if var_82_9 == 0 then
																						arg_82_0.temp_choke, arg_82_0.pulse_counter = 1, arg_82_0.pulse_counter + 1 + 0

																						if arg_82_0.pulse_counter >= 9 then
																							arg_82_0.pulse_state, arg_82_0.pulse_counter = var_0_8("\xA5<JV", ">\xCDU-"), 0
																						end

																						break
																					end
																				end
																			end

																			break
																		end
																	end

																	break
																end

																if var_82_4 == 0 then
																	var_82_5 = 0

																	local var_82_10

																	var_82_4 = 1
																end
															end
														elseif ui.get(var_27_20.ragebot.exploits.fakelag) == var_0_8("C\t\xAD\xA6\x01\x80\x1DlL\xA3\xA8\x11\x8C\r", "i\x15l\xC1\xC9b\xE9") then
															local var_82_11 = 0
															local var_82_12
															local var_82_13
															local var_82_14

															while true do
																if var_82_11 == 1 then
																	local var_82_15

																	while true do
																		if var_82_12 == 1 then
																			if var_82_3 >= var_82_13[#var_82_13] then
																				arg_82_0.temp_choke = var_82_15[#var_82_15]
																			end

																			break
																		end

																		if var_82_12 == 0 then
																			local var_82_16 = 0

																			while true do
																				if var_82_16 == 1 then
																					var_82_12 = 1

																					break
																				end

																				if var_82_16 == 0 then
																					var_82_13, var_82_15 = {
																						5,
																						35,
																						75,
																						125,
																						175,
																						225
																					}, {
																						1,
																						2,
																						4,
																						8,
																						10,
																						12,
																						14
																					}

																					for iter_82_0, iter_82_1 in ipairs(var_82_13) do
																						if var_82_3 < iter_82_1 then
																							arg_82_0.temp_choke = var_82_15[iter_82_0]

																							break
																						end
																					end

																					var_82_16 = 1
																				end
																			end
																		end
																	end

																	break
																end

																if var_82_11 == 0 then
																	var_82_12 = 0
																	var_82_13 = nil
																	var_82_11 = 1
																end
															end
														elseif ui.get(var_27_20.ragebot.exploits.fakelag) == var_0_8("b\x97\x1E\xFF\xC8~\xD6A\x82\x18\xF1\xCE.", "\xBA \xE5{\x9E\xA3^") then
															local var_82_17 = var_82_2:length() * globals.tickinterval()
															local var_82_18 = math.floor(1 / globals.tickinterval())

															arg_82_0.temp_choke = var_82_3 > 5 and math.min(math.ceil(var_82_18 / var_82_17), var_82_1 + 1) or 1
														end

														ui.set(var_27_11.reference.exploits.fakelag_amount, ui.get(var_27_11.reference.exploits.fakeduck) and 14 or var_27_10(arg_82_0.temp_choke, 1, var_27_8:is_active() and 2 or var_82_1 + 1 + 0))

														break
													end
												end
											end
										},
										[var_0_8("\r-x\xDE", "WdC\x11\xAAy\xC5")] = function(arg_83_0, arg_83_1)
											arg_83_0.exploits:fakelag_modifier(arg_83_1)
										end,
										[var_0_8("煳\x94h\xA5\xFC\x8E\xBE\x89T\xA1", "Վ\xEB\xDA\xE07")] = function(arg_84_0, arg_84_1)
											arg_84_0.exploits:extend_peek(arg_84_1)
										end
									},
									[var_0_8("\t\xAC\xED\xCC\t\xAB\xF4", "\xA5h\xC2\x99")] = {
										[var_0_8("\x895ܯ\xC6_\x8C\x84;ʿ\xF8_", "\xED\xE7P\xB9˙=")] = false,
										[var_0_8("\xAB5\x85vz\xB61\x86wQ\xBC", "%\xC5P\xE0\x12")] = function(arg_85_0)
											local var_85_0 = 0
											local var_85_1
											local var_85_2

											while true do
												local var_85_3 = 0

												while true do
													if var_85_3 == 0 then
														if var_85_0 == 1 then
															if utilz:contains(ui.get(var_27_20.antiaim.safety), var_0_8("o\"\xAA\x01N]F)", "4 L\x8Aj ")) and var_85_1 == var_0_8("\x9B\xD1>\xCF|\xBD", "\x1AؚP\xA6") and var_85_2 then
																return true
															end

															return false
														end

														if var_85_0 == 0 then
															var_85_1, var_85_2 = entity.get_classname(var_27_11.weapon), entity.get_prop(var_27_11.local_player, var_0_8("\x14}JJ\x90\fAGg\xB9\x16WBR", "\xD4y\",&")) > 0.1

															if utilz:contains(ui.get(var_27_20.antiaim.safety), var_0_8("\x95\xB4j\x1F{\xB8\xE1", ">\xDA\xDAJe\x1E͒")) and var_85_1 == var_0_8("a\x9E|\xF0\xCD1J\x1BC\xBA|\xE3", "O\"\xC9\x19\x91\xBD^$") and var_85_2 then
																return true
															end

															var_85_0 = 1
														end

														break
													end
												end
											end
										end,
										[var_0_8("\xDF\xCC\xF9Vm\x13\xD5\xC8\xFA", "L\xAC\xA9\x8D#\x1D")] = function(arg_86_0, arg_86_1)
											local var_86_0 = {
												[var_0_8("\xD6\xD0\xEC\x17\xD9\xCB\xC7\x17\xC5\xC9\xFD", "c\xBC\xB9\x98")] = ui.get(var_27_21.antiaim.builder[player:current_state()][1]),
												[var_0_8("\xD8\x1D\xA2\x1A\xA6\xC0+\xB5\x1B\xB0\xC6\x1B\xBB\a\xB9\xD7", "òt\xD6n")] = ui.get(var_27_21.antiaim.builder[player:current_state()][2]),
												[var_0_8("\x1C\xF6\x91", "\x86e\x97\xE6\x15\xA1")] = ui.get(var_27_21.antiaim.builder[player:current_state()][3]),
												[var_0_8("\xAF\x83(G7\r\xF9\xA8\x9D", "\x80\xC9\xEAZ4CR")] = ui.get(var_27_21.antiaim.builder[player:current_state()][4]),
												[var_0_8("\xB7H={Ġr'u\xDD", "\xAA\xC4-^\x14")] = ui.get(var_27_21.antiaim.builder[player:current_state()][5]),
												[var_0_8("zA\t5\xD8", "P\x1E$eT\xA1@")] = ui.get(var_27_21.antiaim.builder[player:current_state()][6]) / 10
											}
											local var_86_1 = 0
											local var_86_2 = 0
											local var_86_3 = arg_86_1.command_number % (4 * var_86_0.delay) >= 2 * var_86_0.delay and 1 or -1

											if var_86_0.jitter_customize == var_0_8("\x82T\x1FC\xCD7\xB2", "[\xC61y\"\xB8") then
												var_27_11.cache.antiaim.lerp_yaw = utilz.math:fast_lerp(var_27_11.cache.antiaim.lerp_yaw, var_86_3 == 1 and var_86_0.yaw or 0, 0.2)
											else
												var_27_11.cache.antiaim.lerp_yaw = utilz.math:fast_lerp(var_27_11.cache.antiaim.lerp_yaw, var_86_3 == 1 and var_86_0.first_yaw or var_86_0.second_yaw, 0.2)
											end

											if var_86_0.jitter_type == var_0_8("\x1A\xC9y\xBC", "\xE9T\xA6\x17\xD9") then
												var_86_2 = var_86_0.yaw
											elseif var_86_0.jitter_type == var_0_8("W~\xFE\xF535", "A\x18\x18\x98\x86V") then
												if var_86_0.jitter_customize == var_0_8("\x982\xEEH\xA9;\xFC", ")\xDCW\x88") then
													var_86_2 = var_86_2 + var_86_3 == 1 and var_86_0.yaw or 0
												else
													var_86_2 = var_86_2 + var_86_3 == 1 and var_86_0.first_yaw or var_86_0.second_yaw / 1.2
												end
											elseif var_86_0.jitter_type == var_0_8("\x063\xED\xE4˹", "\xCBEV\x83\x90\xAE") then
												if var_86_0.jitter_customize == var_0_8("\x9D\x1BUX\xDD\\\xF3", "q\xD9~39\xA80\x87") then
													var_86_2 = var_86_2 + var_86_3 == 1 and var_86_0.yaw or -var_86_0.yaw
												else
													var_86_2 = var_86_2 + var_86_3 == 1 and var_86_0.first_yaw or var_86_0.second_yaw
												end
											elseif var_86_0.jitter_type == var_0_8("3\x10$XM{", "\xAE\x7FuV((\x1F\x16") then
												var_86_2 = var_86_2 + var_27_11.cache.antiaim.lerp_yaw
											end

											var_86_1 = arg_86_0.need_backstab and -180 or arg_86_0:need_safety() and 16 or var_86_1
											var_86_2 = arg_86_0.need_backstab and 0 or arg_86_0:need_safety() and 0 or var_86_2

											return utilz.math:normalize_yaw(var_86_1 + var_86_2)
										end,
										[var_0_8("\xCF>X\xCE\xCC\x04H\xDE\xCF\"B\xD8", "\xBB\xBC[,")] = function(arg_87_0, arg_87_1)
											local var_87_0 = 0
											local var_87_1
											local var_87_2
											local var_87_3

											while true do
												if var_87_0 == 0 then
													local var_87_4 = 0

													while true do
														if var_87_4 == 1 then
															var_87_0 = 1

															break
														end

														if var_87_4 == 0 then
															var_87_1 = 0
															var_87_2 = nil
															var_87_4 = 1
														end
													end
												end

												if var_87_0 == 1 then
													local var_87_5

													while true do
														local var_87_6 = 0
														local var_87_7

														while true do
															if var_87_6 == 0 then
																local var_87_8 = 0

																while true do
																	if var_87_8 == 0 then
																		if var_87_1 == 1 then
																			return arg_87_0.need_backstab and 0 or arg_87_0:need_safety() and 1 or var_87_2
																		end

																		if var_87_1 == 0 then
																			local var_87_9

																			var_87_2, var_87_9 = 0, ({
																				[var_0_8("3\xF2x1", "m\x7F\x97\x1EE\x82")] = -1,
																				[var_0_8("\xE8\x80e\x17", "v\xB2\xE5\x17x\xA5\xB0\xD2")] = 0,
																				[var_0_8("7\xD5K\x01\x18", "\xDDe\xBC,il\xCFA")] = 1
																			})[ui.get(var_27_21.antiaim.builder[player:current_state()][8])]

																			if ui.get(var_27_21.antiaim.builder[player:current_state()][7]) ~= var_0_8("e$\x16\xB6\xDBU", "\xB26Pw\xC2") then
																				var_87_2 = arg_87_1.command_number % (4 * (ui.get(var_27_21.antiaim.builder[player:current_state()][6]) / 10)) >= 2 * (ui.get(var_27_21.antiaim.builder[player:current_state()][6]) / 10) and 1 or -1
																			else
																				var_87_2 = var_87_9
																			end

																			var_87_1 = 1
																		end

																		break
																	end
																end

																break
															end
														end
													end

													break
												end
											end
										end,
										[var_0_8("'\nU\xD7\xFFƽ\xC72\nO\xD1\xE6\xEF\xBC", "\xA2To!\xA2\x8F\x99\xD9")] = function(arg_88_0, arg_88_1)
											if not ui.get(var_27_21.antiaim.builder[player:current_state()][9]) == var_0_8("\x06\xD7\n\x8B>\xC8]\x85)", "\xEAG\xBB}") then
												return 0, 89
											end

											if not var_27_8:in_defensive() then
												return 0, 89
											end

											local var_88_0 = 0
											local var_88_1 = 0
											local var_88_2 = {
												[var_0_8("\x015EX\xF6.1^_\xFB", "\x9Eq\\1;")] = ui.get(var_27_21.antiaim.builder[player:current_state()][10]),
												[var_0_8("\xFFgHd\xFD\x0E\xE5\n\xE3tD", "g\x8C\x10!\x10\x9Ef\xBA")] = ui.get(var_27_21.antiaim.builder[player:current_state()][11]),
												[var_0_8("\xC1\x84\xAFf\x17\x03ׄ\xA9v\v", "\\\xA7\xED\xDD\x15c")] = ui.get(var_27_21.antiaim.builder[player:current_state()][12]),
												[var_0_8("\xEC%.)\xF1$\x126\xF64..", "F\x9F@M")] = ui.get(var_27_21.antiaim.builder[player:current_state()][13]),
												[var_0_8("\xD3J^\xFE\x03", "z\xB7/2\x9F")] = ui.get(var_27_21.antiaim.builder[player:current_state()][14]) / 10
											}
											local var_88_3 = {
												[var_0_8("\xDB0\xB0p\x8D\xCD5\xA2", "\xE0\xA2Q\xC7/")] = ui.get(var_27_21.antiaim.builder[player:current_state()][15]),
												[var_0_8("\xFBR:)\x80\xE0z>2\x87\xED", "\xE3\x88%S]")] = ui.get(var_27_21.antiaim.builder[player:current_state()][16]),
												[var_0_8("_\xA4\x1AgM\x92\x11uN", "\x149\xCDh")] = ui.get(var_27_21.antiaim.builder[player:current_state()][17]),
												[var_0_8(";\xAE\x1B\xB6\x14^\f1\xAA\x0F", "SH\xCBx\xD9z:")] = ui.get(var_27_21.antiaim.builder[player:current_state()][18]),
												[var_0_8("\xB8췢\xB6", "\xDF܉\xDB\xC3\xCF\xDD")] = ui.get(var_27_21.antiaim.builder[player:current_state()][19]) / 10
											}
											local var_88_4 = arg_88_1.command_number % (4 * var_88_2.delay) >= 2 * var_88_2.delay and 1 or -1
											local var_88_5 = arg_88_1.command_number % (4 * var_88_3.delay) >= 2 * var_88_3.delay and 1 or -1

											var_27_11.cache.antiaim.lerp_pitch = utilz.math:fast_lerp(var_27_11.cache.antiaim.lerp_pitch, var_88_4 == 1 and var_88_2.first_pitch or var_88_2.second_pitch, 0.2)
											var_27_11.cache.antiaim.lerp_yaw_defensive = utilz.math:fast_lerp(var_27_11.cache.antiaim.lerp_yaw_defensive, var_88_5 == 1 and var_88_3.first_yaw or var_88_3.second_yaw, 0.2)

											if var_88_2.pitch_mode == var_0_8("0]L\xF6#\x1E", "Ls(?\x82") then
												if var_88_2.switch_mode == var_0_8("\xAD\x139\xB9\xB3\xC3", "\xB1\xE7zM\xCD\xD6") then
													var_88_1 = var_88_1 + var_88_4 == 1 and var_88_2.first_pitch or var_88_2.second_pitch
												else
													var_88_1 = var_88_1 + var_27_11.cache.antiaim.lerp_pitch
												end
											else
												var_88_1 = ({
													[var_0_8("`\x1CVN", "<$s! \xC9")] = 89,
													[var_0_8("\x82f", "\xC1\xD7\x167&,>]")] = -89,
													[var_0_8("\x15\x17\x1C\xC0", "\x9BOrn\xAF\xB5")] = 0,
													[var_0_8("jU\xD7ཱྀ", "\xB584\xB9\x84\xD1\xEC")] = client.random_int(-89, 89)
												})[var_88_2.pitch_mode]
											end

											if var_88_3.yaw_mode == var_0_8("\x11Y\xC1\xBCJ\xA4", "\x9AR,\xB2\xC8%\xC9") then
												if var_88_3.switch_mode == var_0_8("_\xE2\x16\x19\xBBZ", "\x15\x15\x8Bbm\xDE(") then
													var_88_0 = var_88_0 + var_88_5 == 1 and var_88_3.first_yaw or var_88_3.second_yaw
												else
													var_88_0 = var_88_0 + var_27_11.cache.antiaim.lerp_yaw_defensive
												end
											else
												var_88_0 = ({
													[var_0_8("*㢉", "Zd\x8C\xCC\xEC")] = var_88_0,
													[var_0_8("\x9F\x1D:ɠ\x19\xB5\a", "x\xCCt^\xAC\xD7")] = var_88_0 + 90 * (arg_88_1.command_number % 4 >= 2 and 1 or -1),
													[var_0_8("0\xAD\xB1\x06", "\x1Fc\xDD\xD8h\x8B\xC2\x10")] = var_88_0 + math.fmod(globals.curtime() * 520, 180) * 2,
													[var_0_8("\a\xA1\xE4\b\x06\xEE", "\x83U\xC0\x8Ali")] = var_88_0 + client.random_int(-180, 180)
												})[var_88_3.yaw_mode]
											end

											var_88_0 = arg_88_0.need_backstab and -180 or arg_88_0:need_safety() and 16 or var_88_0
											var_88_1 = arg_88_0.need_backstab and 89 or arg_88_0:need_safety() and 89 or var_88_1

											return utilz.math:normalize_yaw(var_88_0), var_27_10(var_88_1, -89, 89)
										end,
										[var_0_8("9\xB2z\x11$\xAD{\x06", "cV\xC4\x1F")] = function(arg_89_0, arg_89_1)
											local var_89_0 = 0
											local var_89_1
											local var_89_2

											while true do
												if var_89_0 == 1 then
													var_27_11.cache.antiaim.ground_ticks = var_0_11.band(entity.get_prop(var_27_11.local_player, var_0_8("\xF1'r%8\x04\xA9\xEC", "\x9F\x9Cx\x14cTe\xCE")), 1) == 1 and var_27_11.cache.antiaim.ground_ticks + 1 + 0 or 0

													if ui.get(var_27_21.antiaim.builder[player:current_state()][9]) == var_0_8("]\x1D\x9B~\xD1R7(r", "G\x1Cq\xEC\x1F\xA8!\x17") then
														var_27_8:should_force_defensive(true)
													end

													var_89_0 = 2
												end

												if var_89_0 == 2 then
													if ui.get(var_27_11.reference.antiaim.pitch_mode[1]) ~= var_0_8("n\xEB0\xEC\xD6\xD4", "\xC7-\x9EC\x98\xB9\xB9[") then
														ui.set(var_27_11.reference.antiaim.pitch_mode[1], var_0_8("yl\xAE\xBA\xDF\x1B", "\xB0:\x19\xDDΰv\xB7"))
													end

													if ui.get(var_27_11.reference.antiaim.angles.yaw_jitter[2]) ~= 0 then
														ui.set(var_27_11.reference.antiaim.angles.yaw_jitter[2], 0)
													end

													var_89_0 = 3
												end

												if var_89_0 == 0 then
													local var_89_3 = 0

													while true do
														if var_89_3 == 1 then
															var_89_0 = 1

															break
														end

														if var_89_3 == 0 then
															local var_89_4

															var_89_1, var_89_4 = client.current_threat(), utilz:contains(ui.get(var_27_20.antiaim.safety), var_0_8("r5L\xF6L\xB3\x0ER", "o0T/\x9D?\xC7")) and player:is_valid(var_89_1)
															arg_89_0.need_backstab = var_89_4 and wpn_class == var_0_8("9-\x8E\xAE(\x1F", "Nzf\xE0\xC7") and distance_to_ent <= 275 or false
															var_89_3 = 1
														end
													end
												end

												if var_89_0 == 3 then
													if ui.get(var_27_11.reference.antiaim.angles.desync[1]) ~= var_0_8("\x01\x05\xD8\x12\xE7\xBB", "\xD8Rq\xB9f\x8E") then
														ui.set(var_27_11.reference.antiaim.angles.desync[1], var_0_8("qO!\xCCtA", "\x1D\";@\xB8"))
													end

													if arg_89_1.chokedcommands == 0 then
														local var_89_5 = 0
														local var_89_6
														local var_89_7

														while true do
															if var_89_5 == 0 then
																local var_89_8

																var_89_6, var_89_8 = arg_89_0:setup_defensive(arg_89_1)

																ui.set(var_27_11.reference.antiaim.pitch_mode[2], ui.get(var_27_21.antiaim.builder[player:current_state()][9]) == var_0_8("3\x12_\xCB,NR\x11F", "=r~(\xAAU") and var_27_8:in_defensive() and var_89_8 or 89)

																var_89_5 = 1
															end

															if var_89_5 == 1 then
																ui.set(var_27_11.reference.antiaim.angles.yaw[2], ui.get(var_27_21.antiaim.builder[player:current_state()][9]) == var_0_8("\xED$`8\xDA`\x8C'y", "\x13\xACH\x17Y\xA3") and var_27_8:in_defensive() and (var_89_6 == 0 and arg_89_0:setup_yaw(arg_89_1) or var_89_6) or arg_89_0:setup_yaw(arg_89_1))
																ui.set(var_27_11.reference.antiaim.angles.desync[2], arg_89_0:setup_desync(arg_89_1))

																break
															end
														end
													end

													break
												end
											end
										end
									},
									[var_0_8("!U\xDC\xF04^\xB6", "\xC5W<\xAF\x85U2")] = {
										[var_0_8("\x18q\xD3\xC0", "\xB3t\x1E\xB4")] = {
											[var_0_8("\xF8\xD2\xEC\x82\xE0", "ዦ\x8D")] = {},
											[var_0_8("E\x82\xE0'_\x84\xE10^", "@-\xEB\x94")] = {
												var_0_8("qT4\xE7N\xDCu", "\xB5\x161Z\x82<"),
												var_0_8("\aԹ\r", "io\xB1\xD8"),
												var_0_8("\xB7\x12\xCD\x01\x04", "\xB3\xD4z\xA8rp"),
												var_0_8("jn\x8B\xC0xy\x8C", "\xAD\x19\x1A\xE4"),
												var_0_8("\x1AsϮX\x17d\xC4", "xv\x16\xA9\xDA"),
												var_0_8("\xD5)\xB1\xEE\xD3`\xB7\xF4\xCA", "\x86\xA7@\xD6"),
												var_0_8("\b\x8C\xF8\x9C\x89\xC4\x01\x8E", "\xA8d\xE9\x9E\xE8\xA9"),
												var_0_8("`]\x1E\xF4f\x14\x15\xF9u", "\x9C\x124y"),
												var_0_8("M\x15\xD8\xC1", "\xBF#p\xBB\xAA\xE4\xD5e"),
												"?",
												var_0_8("\xBF\xAA}G", "\x1F\xD8\xCF\x1C5^|")
											},
											[var_0_8(",.\xB8\x1C^%", ";AG\xCBo")] = false,
											[var_0_8("\x11\xA9nq\x8F", "Tw\xC0\x1C\x14\xEBl")] = false,
											[var_0_8("\x9E\xFB'\xF9\b8", "!\xEC\x9ED\x96z\\\xC9")] = {
												[var_0_8("\xE8\xDB", "Y\x80\xB8\x99y)\x91")] = 0,
												[var_0_8("\xE42", "[\x8CU\xC4\xE1B\xE7`")] = "",
												[var_0_8("#\xBC\xBA\xB6", "+S\xD8\xD7\xD1")] = 0,
												[var_0_8("I\xB3", "N+\xC7\xD0k")] = 0,
												[var_0_8("s\x8B\x03", "\xB6\x12\xE8`~\xDBZ\xA5")] = false,
												[var_0_8("5N", "\xC8]>G")] = false,
												[var_0_8("CUZ", "n&-.\xBA\xA4\xD2")] = false,
												[var_0_8("t\xBD", "^\x18\xDE\xC8v")] = false,
												[var_0_8("\r\xCF5", "y}\xA0F")] = var_27_6(0, 0, 0)
											},
											[var_0_8("\xE1\xEF:\xA1\xFC\xE4", "ғ\x8A[")] = ""
										},
										[var_0_8("4\xF3\xC1F1\a<\xF2\xC6X", "sU\x9D\xA8+P")] = {
											[var_0_8("\xE8[\x93R\x9E\xC4G\xDB\xF4e\x86[\x9C\xC1G", "\xA9\x9F:\xE77\xEC\xA9&")] = 0,
											[var_0_8("\x1AĦ\x12\xCD\x1Ax\x02", "\x1Cq\xA1\xDFp\xA4t")] = {
												[var_0_8("\xC7TWqZ", ";\xA68'\x19")] = 0,
												[var_0_8("\xA5\xD1\xC2\xDCK", "#Ҹ\xA6\xA8")] = 0,
												[var_0_8("[PsF7HIVn", "\x1799\x1D\"D")] = 0,
												[var_0_8("X0\t)o3\x16\"T\"", "L0Q\x7F")] = false
											},
											[var_0_8("\x02\xAAV\xA45u\xD1@\x06\xA4", "0n\xC51\xD7j\x14\xBD")] = 0,
											[var_0_8("\x0E\x1EG\xBB\xC5/y\b\x12\x05F\x93\xC1'V\x04\x1C", "l}r(̠K&")] = 0
										},
										[var_0_8("\"y\xF1\t:g\xEC29y\xEC\x19", "mU\x10\x9F")] = {
											{
												[var_0_8(".\xF0\xA2U", "\xD0G\x93\xCD;{8")] = renderer.load_png(readfile(var_0_8("S%\x88\xB9Nn\x94\xB6P", "\xD87@\xE4")), 50, 50),
												[var_0_8("\xA9\x892׼", "\x8B\xDF\xE8^\xA2ٕ")] = function()
													local var_90_0 = 0
													local var_90_1

													while true do
														if var_90_0 == 0 then
															local var_90_2 = 0

															while true do
																if var_90_2 == 0 then
																	local var_90_3 = 0

																	while true do
																		if var_90_3 == 0 then
																			local var_90_4 = math.ceil(client.real_latency() * 1000 * 0.8199999999999363)

																			return var_90_4 > 30 and var_90_4 or var_0_8("یc\xF5\xBEY\xCB\xCC", "\xAA\xB5\xE3C\x91\xDB5")
																		end
																	end
																end
															end
														end
													end
												end
											},
											{
												[var_0_8("P\x86\x11\xBC", "\xD29\xE5~")] = renderer.load_png(readfile(var_0_8("\xAA2\xFE\xA3|Ս\xBF", "\xE3\xD8S\x8A\xC6R\xA5")), 50, 50),
												[var_0_8("=\xB4\xBAm\xF7", "\x92K\xD5\xD6\x18")] = function()
													return math.floor(1 / globals.tickinterval())
												end
											},
											{
												[var_0_8("C}\xCEJ", "5*\x1E\xA1$\x1A%")] = renderer.load_png(readfile(var_0_8("\xFB\xE9\xE4\xAE\xED\xF7\xF0", "\x80\x9D\x99\x97")), 50, 50),
												[var_0_8("`t\x80<\x10", "\x13\x16\x15\xECIu")] = function()
													return math.floor(1 / globals.frametime())
												end
											},
											{
												[var_0_8("~ƭ\xA7", "\x96\x17\xA5\xC2ɗ\xDDM")] = renderer.load_png(readfile(var_0_8("r4\xEF\x150+\xE6\x1D", "z\x1E[\x88")), 50, 50),
												[var_0_8("\xA9\xA5饈", "\xED\xDFą\xD0")] = function()
													return var_0_8("\xD4\x11ӻL\xE9\xC8\aͻ", "\x9A\xBCh\xA3\xDE>")
												end
											}
										},
										[var_0_8(">\xE84\xF9\x19A\xC6&\xD2$\xF8\x1FA", "\xA2U\x8DM\x9Bp/")] = renderer.load_png(readfile(var_0_8("\x19,\xBFL\x1B'\xA2]\\9\xA8I", ".rI\xC6")), 50, 50),
										[var_0_8("\xA9qq\xFC\x11C\xA6qx", "*\xC5\x1E\x16\x8FN")] = renderer.load_png(readfile(var_0_8("\x7FJX,=UQ8", "_\x13%?")), 50, 50),
										[var_0_8("b \xA8\xEBt\x03N(\xA8\xEB\x7F8x/\xA8\xF2", "g\x11Lǜ\x11")] = renderer.load_png(readfile(var_0_8("\xA4+\x97\xE6U\x1E\xBE\xB4\xA3$\x82", "\x9A\xD3J\xE5\x88<p\xD9")), 50, 50),
										[var_0_8("\xB8\x15\xE4\xC9\nP\xBC", "'\xCF|\x8A\xADe")] = function(arg_94_0)
											local var_94_0 = var_27_6(ui.get(var_27_20.visuals.screen.windows_theme))
											local var_94_1 = 1

											arg_94_0.animations.keybinds.have_binds = false

											for iter_94_0 = 1, #var_27_23.binds do
												if var_27_23.binds[iter_94_0].bind() then
													arg_94_0.animations.keybinds.have_binds = true

													break
												end
											end

											local var_94_2 = 100 - math.floor(entity.get_prop(var_27_11.local_player, var_0_8("\xC3>E̔\xCB\rLë\xDA\x18nϦ\xC7\aJŰ", "®a#\xA0")) * 100)

											arg_94_0.animations.watermark_alpha = utilz.math:fast_lerp(arg_94_0.animations.watermark_alpha, utilz:contains(ui.get(var_27_20.visuals.screen.windows), var_0_8("\xC8!)\a\xED-<\x10\xF4", "b\x9F@]")) and 1 or 0, 0.049999999999954525)
											arg_94_0.animations.keybinds.alpha = utilz.math:fast_lerp(arg_94_0.animations.keybinds.alpha, utilz:contains(ui.get(var_27_20.visuals.screen.windows), var_0_8("%\xB44\x1D\x18\b_7", "Dn\xD1M\x7Fqf;")) and arg_94_0.animations.keybinds.have_binds and 1 or 0, 0.05)
											arg_94_0.animations.logs_alpha = utilz.math:fast_lerp(arg_94_0.animations.logs_alpha, utilz:contains(ui.get(var_27_20.visuals.screen.windows), var_0_8("\x82\xEB\xA0\\", "\xCE΄\xC7/c\xA3")) and arg_94_0.logs.fired and 1 or 0, 0.01)
											arg_94_0.animations.slowed_down_alpha = utilz.math:fast_lerp(arg_94_0.animations.slowed_down_alpha, utilz:contains(ui.get(var_27_20.visuals.screen.windows), var_0_8("\xC5\xCE\xD8eT\xF2\x82\xD3}F\xF8", "1\x96\xA2\xB7\x12")) and var_94_2 > 0 and 1 or 0, 0.01)

											local var_94_3 = 0
											local var_94_4 = 17
											local var_94_5 = var_27_6(40, 23)

											if arg_94_0.animations.watermark_alpha ~= 0 then
												for iter_94_1 = 1, #arg_94_0.windows_list do
													local var_94_6 = arg_94_0.windows_list[iter_94_1]

													if var_94_6 then
														local var_94_7 = 0
														local var_94_8
														local var_94_9
														local var_94_10

														while true do
															if var_94_7 == 0 then
																local var_94_11 = 0

																while true do
																	if var_94_11 == 1 then
																		var_94_7 = 1

																		break
																	end

																	if var_94_11 == 0 then
																		var_94_8, var_94_9 = var_94_6.value(), var_27_6(var_94_5.x, var_94_5.y)

																		if var_94_8 then
																			local var_94_12 = 0
																			local var_94_13

																			while true do
																				if var_94_12 == 0 then
																					local var_94_14 = renderer.measure_text("b", var_94_8)

																					var_94_9.x = var_94_9.x + 6 + 5 + var_94_14

																					break
																				end
																			end
																		end

																		var_94_11 = 1
																	end
																end
															end

															if var_94_7 == 1 then
																local var_94_15 = 0

																while true do
																	if var_94_15 == 1 then
																		var_94_7 = 2

																		break
																	end

																	if var_94_15 == 0 then
																		var_94_10 = var_27_6(var_27_11.screen_size.x - var_94_3 - var_94_9.x - 6, 15)
																		var_94_3 = var_94_3 + var_94_9.x + 5 + 1 + 10
																		var_94_15 = 1
																	end
																end
															end

															if var_94_7 == 2 then
																utilz.render:window(var_94_4 - 2, var_94_10, var_94_9, var_94_0, arg_94_0.animations.watermark_alpha, true)
																renderer.texture(var_94_6.icon, var_94_10.x - var_94_4 / 2, var_94_10.y + var_94_5.y / 2 - var_94_4 / 2, var_94_4, var_94_4, 255, 255, 255, 255 * arg_94_0.animations.watermark_alpha, "f")

																var_94_7 = 3
															end

															if var_94_7 == 3 then
																utilz.render:text(var_27_6(var_94_10.x + var_94_9.x / 2, var_94_10.y + var_94_9.y / 2), var_27_6(255, 255, 255), arg_94_0.animations.watermark_alpha, var_0_8("J(", "x)J\xDBAz\x80"), var_94_8)

																break
															end
														end
													end
												end
											end

											if arg_94_0.animations.logs_alpha ~= 0 then
												for iter_94_2, iter_94_3 in ipairs(arg_94_0.logs.stack) do
													local var_94_16 = 0
													local var_94_17
													local var_94_18

													while true do
														if var_94_16 == 1 then
															while true do
																if var_94_17 == 1 then
																	local var_94_19 = 0

																	while true do
																		if var_94_19 == 1 then
																			var_94_17 = 2

																			break
																		end

																		if var_94_19 == 0 then
																			local var_94_20 = var_27_6(renderer.measure_text("c", iter_94_3.text))

																			utilz.render:window(var_94_4, var_27_6(10 + var_94_4, 8 + (iter_94_2 - 1) * 33), var_27_6(12 + var_94_4 * 2 + var_94_20.x, 10 + var_94_20.y), var_94_0, arg_94_0.animations.logs_alpha * iter_94_3.alpha, true)

																			var_94_19 = 1
																		end
																	end
																end

																if var_94_17 == 0 then
																	local var_94_21 = 0

																	while true do
																		if var_94_21 == 0 then
																			iter_94_3.timer = iter_94_3.timer - globals.frametime()

																			if iter_94_3.timer <= 0 then
																				table.remove(arg_94_0.logs.stack, iter_94_2)
																			else
																				iter_94_3.alpha = math.max(0, iter_94_3.alpha - 0.0005)
																			end

																			var_94_21 = 1
																		end

																		if var_94_21 == 1 then
																			var_94_17 = 1

																			break
																		end
																	end
																end

																if var_94_17 == 2 then
																	renderer.texture(arg_94_0.logs_icon, 10 + var_94_4 / 2, 11 + (iter_94_2 - 1) * 33, var_94_4, var_94_4, 255, 255, 255, 200 * arg_94_0.animations.logs_alpha * iter_94_3.alpha, "f")
																	utilz.render:text(var_27_6(16 + var_94_4 * 2, 13 + (iter_94_2 - 1) * 33), var_27_6(255, 255, 255), arg_94_0.animations.logs_alpha * iter_94_3.alpha, "", iter_94_3.text)

																	break
																end
															end

															break
														end

														if var_94_16 == 0 then
															var_94_17 = 0

															local var_94_22

															var_94_16 = 1
														end
													end
												end
											end

											if arg_94_0.animations.keybinds.alpha ~= 0 then
												local var_94_23 = 0
												local var_94_24
												local var_94_25
												local var_94_26
												local var_94_27

												while true do
													if var_94_23 == 1 then
														local var_94_28 = 0
														local var_94_29

														while true do
															if var_94_28 == 0 then
																local var_94_30 = 0

																while true do
																	if var_94_30 == 1 then
																		var_94_26 = var_94_25.pos.x + (arg_94_0.animations.keybinds.width - var_94_25.keybinds_size.x / 2) / 2
																		var_94_23 = 2

																		break
																	end

																	if var_94_30 == 0 then
																		var_94_25.width_raw = math.max(var_94_25.width_raw, var_94_25.keybinds_size.x + 35)
																		arg_94_0.animations.keybinds.width = utilz.math:fast_lerp(arg_94_0.animations.keybinds.width, arg_94_0.animations.keybinds.have_binds and var_94_25.width_raw or 45, 0.05)
																		var_94_30 = 1
																	end
																end

																break
															end
														end
													end

													if var_94_23 == 2 then
														utilz.render:window(var_94_4 - 2, var_94_25.pos, var_27_6(50 + arg_94_0.animations.keybinds.width, var_94_25.keybinds_size.y + 6), var_94_0, arg_94_0.animations.keybinds.alpha, true)
														renderer.texture(arg_94_0.keybinds_icon, var_94_25.pos.x - var_94_4 / 2, var_94_25.pos.y + 3, var_94_4, var_94_4, 255, 255, 255, 200 * arg_94_0.animations.keybinds.alpha, "f")
														utilz.render:text(var_27_6(var_94_26 + 14, var_94_25.pos.y + 5), var_27_6(255, 255, 255), arg_94_0.animations.keybinds.alpha, "l", var_0_8("N P\xCCL+M\xDD", "\xAE%E)"))

														var_94_23 = 3
													end

													if var_94_23 == 0 then
														local var_94_31 = 0

														while true do
															if var_94_31 == 1 then
																for iter_94_4 = 1, #var_27_23.binds do
																	if var_27_23.binds[iter_94_4].bind() then
																		var_94_25.width_raw = math.max(var_94_25.width_raw, var_27_6(renderer.measure_text("", var_27_23.binds[iter_94_4].text)).x + 20)
																	end
																end

																var_94_23 = 1

																break
															end

															if var_94_31 == 0 then
																local var_94_32 = var_27_6(renderer.measure_text("c", var_0_8("Q\x03E\x18\xEC\xA9\xD1I", "\xB5:f<z\x85\xC7")))

																var_94_25 = {
																	[var_0_8("C\xED\xCF", "\x1A3\x82\xBCy")] = var_27_6(350, 350),
																	[var_0_8("\xE3\x875\x1B@\x10\xF3Jב%\x03L", "9\x88\xE2Ly)~\x97")] = var_27_6(var_94_32.x, var_94_32.y + 5),
																	[var_0_8("5\xDE\rG,\xDCo#\xC0", "\x1DB\xB7i3D\x83")] = 0
																}
																var_94_31 = 1
															end
														end
													end

													if var_94_23 == 3 then
														local var_94_33 = var_94_25.pos.y + 12 + 11

														for iter_94_5 = 1, #var_27_23.binds do
															local var_94_34 = 0
															local var_94_35
															local var_94_36

															while true do
																if var_94_34 == 0 then
																	var_94_35 = 0

																	local var_94_37

																	var_94_34 = 1
																end

																if var_94_34 == 1 then
																	while true do
																		if var_94_35 == 0 then
																			local var_94_38 = var_27_23.binds[iter_94_5]

																			if var_94_38.bind() then
																				local var_94_39 = 0
																				local var_94_40
																				local var_94_41
																				local var_94_42
																				local var_94_43

																				while true do
																					if var_94_39 == 0 then
																						var_94_40 = 0

																						local var_94_44

																						var_94_39 = 1
																					end

																					if var_94_39 == 2 then
																						while true do
																							if var_94_40 == 0 then
																								local var_94_45 = 0

																								while true do
																									if var_94_45 == 0 then
																										local var_94_46 = var_27_6(renderer.measure_text("d", var_94_38.text))
																										local var_94_47

																										var_94_47, var_94_43 = var_94_38.bind()
																										var_94_45 = 1
																									end

																									if var_94_45 == 1 then
																										var_94_40 = 1

																										break
																									end
																								end
																							end

																							if var_94_40 == 2 then
																								var_94_33 = var_94_33 + 15

																								break
																							end

																							if var_94_40 == 1 then
																								local var_94_48 = 0

																								while true do
																									if var_94_48 == 1 then
																										var_94_40 = 2

																										break
																									end

																									if var_94_48 == 0 then
																										utilz.render:text(var_27_6(var_94_25.pos.x + 2 - var_94_4, var_94_33 + var_94_4 / 2 - 2), var_27_6(255, 255, 255), arg_94_0.animations.keybinds.alpha, "", var_94_38.text)
																										utilz.render:text(var_27_6(var_94_25.pos.x + 7 + arg_94_0.animations.keybinds.width - var_94_4, var_94_33 + var_94_4 / 2 - 2), var_27_6(255, 255, 255), arg_94_0.animations.keybinds.alpha, "", var_94_43 == 1 and var_0_8("\xBA\xBEA\x02\x14\x88\xB8I3", "p\xE1\xD6.n") or var_0_8("%0,\\\xE3\xB1\xE9\x1A\x19", "\x8C~DC;\x84\xDD"))

																										var_94_48 = 1
																									end
																								end
																							end
																						end

																						break
																					end

																					if var_94_39 == 1 then
																						local var_94_49

																						var_94_43 = nil
																						var_94_39 = 2
																					end
																				end
																			end

																			break
																		end
																	end

																	break
																end
															end
														end

														break
													end
												end
											end

											if arg_94_0.animations.slowed_down_alpha ~= 0 then
												local var_94_50 = 0
												local var_94_51
												local var_94_52
												local var_94_53
												local var_94_54

												while true do
													if var_94_50 == 2 then
														utilz.render:text(var_27_6(var_94_54.x + var_94_52 + 9, var_94_54.y + var_94_53.y / 2 - 1), var_27_6(255, 255, 255), arg_94_0.animations.slowed_down_alpha, "d", var_0_8("\xE3@\xCB\\\x82\xD4\f\xC0D\x90\xDE", "\xE7\xB0,\xA4+"))
														utilz.render:text(var_27_6(var_94_54.x + var_94_52 + 5 + 7 + var_94_53.x, var_94_54.y + var_94_53.y / 2 - 1), var_27_6(255, 255, 255), arg_94_0.animations.slowed_down_alpha, "d", var_94_2)

														var_94_50 = 3
													end

													if var_94_50 == 3 then
														renderer.rectangle(var_94_54.x + var_94_52 + 9, var_94_54.y + var_94_53.y * 2 - 2, var_94_2 * 2, 8, 255, 255, 255, 100 * arg_94_0.animations.slowed_down_alpha)

														break
													end

													if var_94_50 == 0 then
														var_94_51, var_94_52, var_94_53 = var_27_6(240, 36), 22, var_27_6(renderer.measure_text("d", var_0_8("\xB1}\b\\H\x1BƆ~\x10E", "\xE6\xE2\x11g+-\x7F")))
														var_94_54 = var_27_6(var_27_11.screen_size.x / 2 - var_94_51.x / 2, var_27_11.screen_size.y / 10)
														var_94_50 = 1
													end

													if var_94_50 == 1 then
														utilz.render:window(var_94_52 - 3, var_94_54, var_94_51, var_94_0, arg_94_0.animations.slowed_down_alpha, true)
														renderer.texture(arg_94_0.slowed_down_icon, var_94_54.x - var_94_52 / 2, var_94_54.y + var_94_52 / 3, var_94_52, var_94_52, 255, 255, 255, 200 * arg_94_0.animations.slowed_down_alpha, "f")

														var_94_50 = 2
													end
												end
											end
										end,
										[var_0_8("\xB2\xC56\xAC\xAB\x82", "\xEC\xC1\xA6D\xC9\xCE")] = {
											[var_0_8("\x055\xC1|\x05/\xC1~\n(", "\x11d[\xA8")] = {
												[var_0_8("S\xA8\x88\xE5\xB0\"oU\xB4\x9F", "\x1B:\xC6\xEC\x8C\xD3C")] = {
													[var_0_8("1\xC2\xDF", "\x8BA\xAD\xAC*\xE9")] = 0,
													[var_0_8("\x94Fx\xD6", "(\xE76\x11\xB8\xA4\x17\x80")] = 0
												}
											},
											[var_0_8("\x80\xC8r\xF9\x82\xEF\xBB\xC0q\xFC\x8C\xE9\x85\xDDp\xEA", "\x8A\xE4\xA9\x1F\x98\xE5")] = function(arg_95_0)
												local var_95_0 = 0
												local var_95_1
												local var_95_2
												local var_95_3
												local var_95_4

												while true do
													if var_95_0 == 1 then
														local var_95_5 = 0

														while true do
															if var_95_5 == 1 then
																var_95_0 = 2

																break
															end

															if var_95_5 == 0 then
																var_95_3 = nil
																var_95_4 = nil
																var_95_5 = 1
															end
														end
													end

													if var_95_0 == 0 then
														local var_95_6 = 0

														while true do
															if var_95_6 == 1 then
																var_95_0 = 1

																break
															end

															if var_95_6 == 0 then
																var_95_1 = 0
																var_95_2 = nil
																var_95_6 = 1
															end
														end
													end

													if var_95_0 == 2 then
														while true do
															if var_95_1 == 2 then
																utilz.render:text(var_27_6(var_95_2.x + 20, var_95_2.y - 20), var_27_6(255, 255, 255), 1, var_0_8("z\x89", "\xCD\x16\xED\x18"), var_95_4)

																if player:is_valid(var_95_3) then
																	local var_95_7 = player:get_simulated_origin(var_27_11.local_player, var_27_6(client.eye_position()), entity.get_prop(var_27_11.local_player, var_0_8("\xB3Gu\xEE5\xBF\x7F`", "Y\xDE\x18\x13\xA8")), 14)
																	local var_95_8 = var_27_6(entity.hitbox_position(var_95_3, 0))
																	local var_95_9, var_95_10 = client.trace_bullet(var_27_11.local_player, var_95_7.x, var_95_7.y, var_95_7.z, var_95_8.x, var_95_8.y, var_95_8.z, false)

																	utilz.render:text(var_27_6(var_95_2.x - 20, var_95_2.y - 20), var_27_6(125, 255, 125), 1, var_0_8("\xE7]", "q\x9593\xD7"), var_95_10)
																end

																break
															end

															if var_95_1 == 1 then
																local var_95_11 = 0

																while true do
																	if var_95_11 == 0 then
																		var_95_4 = ui.get(var_27_11.reference.rage.min_damage_override[2]) and ui.get(var_27_11.reference.rage.min_damage_override[3]) or ui.get(var_27_11.reference.rage.min_damage)
																		var_95_4 = var_95_4 == 0 and var_0_8("&\x04\xE3\x88", "4Gq\x97\xE7\xBB$\xE8") or var_95_4
																		var_95_11 = 1
																	end

																	if var_95_11 == 1 then
																		var_95_1 = 2

																		break
																	end
																end
															end

															if var_95_1 == 0 then
																local var_95_12 = 0

																while true do
																	if var_95_12 == 0 then
																		if not utilz:contains(ui.get(var_27_20.visuals.screen.indicators), var_0_8("\xE8\rO4\xE7\xC6", "\xA3\xACl\"U\x80")) then
																			return
																		end

																		var_95_2, var_95_3 = var_27_6(var_27_11.screen_size.x / 2, var_27_11.screen_size.y / 2 - 10, 0), client.current_threat()
																		var_95_12 = 1
																	end

																	if var_95_12 == 1 then
																		var_95_1 = 1

																		break
																	end
																end
															end
														end

														break
													end
												end
											end,
											[var_0_8("zuŢ\xE7\xD2FyŲ\xEB\xC3xdĤ\xF1", "\xA0\x19\x10\xABւ")] = function(arg_96_0)
												local var_96_0 = 0
												local var_96_1
												local var_96_2
												local var_96_3
												local var_96_4
												local var_96_5
												local var_96_6
												local var_96_7

												while true do
													if var_96_0 == 1 then
														arg_96_0.animations.indicators.pos = utilz.math:fast_lerp(arg_96_0.animations.indicators.pos, var_96_1 and var_96_2.x / 3.5 or -(var_96_2.x / 2), 0.15)
														arg_96_0.animations.indicators.spin = utilz.math:fast_lerp(arg_96_0.animations.indicators.spin, var_27_8:in_defensive() and 1 or 0, 0.04)
														var_96_4 = var_27_6(var_27_11.screen_size.x / 2 + arg_96_0.animations.indicators.pos, var_27_11.screen_size.y / 2 + 17, 0)
														var_96_0 = 2
													end

													if var_96_0 == 0 then
														if not utilz:contains(ui.get(var_27_20.visuals.screen.indicators), var_0_8("R\xDD9ix\xC0", "\xEB\x11\xB8W\x1D\x1D\xB2")) then
															return
														end

														var_96_1 = entity.get_prop(var_27_11.local_player, var_0_8("\xA7\x96{\xD1㙪v\xE8\xF5\xAE", "\x90\xCA\xC9\x19\x98")) == 1 and true or false
														var_96_2, var_96_3 = var_27_6(renderer.measure_text(var_96_1 and var_0_8("5\xDF\x06", "`Y\xBBd\x1E\x9B*\x87") or var_0_8(")\xCF", "\x1DM\xADc*\x1A"), var_27_11.script_name)), var_27_6(ui.get(var_27_20.visuals.screen.indicators_theme))
														var_96_0 = 1
													end

													if var_96_0 == 2 then
														utilz.render:text(var_96_4, var_27_6(255, 255, 255), 1, var_96_1 and var_0_8("\x88\xE6\x05", "m\xE4\x82g\x1A;\x8F\x97") or var_0_8("\x87z", "\xE4\xE3\x18ι^*O"), utilz.str:to_gradient(var_27_6(255, 255, 255), var_96_3, var_27_11.script_name))

														local var_96_8 = math.max(-58, math.min(58, math.floor(entity.get_prop(var_27_11.local_player, var_0_8("\xC3\x1D1\xA4\x84\x14#\xCB\x126\xBA\xB5\x165\xDA'%", "P\xAEBW\xC8\xD4{"), 11) * 120 - 58 + 0.5)))

														var_96_6 = math.ceil(math.abs(var_96_8) / 58 * 100)
														var_96_0 = 3
													end

													if var_96_0 == 3 then
														local var_96_9 = var_96_4.y + var_96_2.y - 3 + 13

														utilz.render:text(var_27_6(var_96_1 and var_96_4.x or var_96_4.x + var_96_2.x / 2, (var_96_1 and var_96_9 or var_96_9 + var_96_2.y / 2) - 11), var_27_6(255, 255, 255), 1, var_96_1 and var_0_8("\xC7}<", "s\xAB\x19^\xA8\x97") or var_0_8("\x0F\xB6\xE6", "\x97l҄A"), var_96_6 .. "%")

														for iter_96_0 = 1, #var_27_23.indicators do
															local var_96_10 = 0
															local var_96_11
															local var_96_12

															while true do
																if var_96_10 == 0 then
																	var_96_11 = 0

																	local var_96_13

																	var_96_10 = 1
																end

																if var_96_10 == 1 then
																	while true do
																		if var_96_11 == 0 then
																			local var_96_14 = var_27_23.indicators[iter_96_0]

																			if var_96_14.indicator() then
																				utilz.render:text(var_27_6(var_96_1 and var_96_4.x or var_96_4.x + var_96_2.x / 2, var_96_1 and var_96_9 or var_96_9 + var_96_2.y / 2), var_27_6(255, 255, 255), 1, var_96_1 and var_0_8("\xD4P\v", "4\xB84i(\xA6!\xA7") or var_0_8("Q\n\xCF", "\xAC2n\xAD\xC8Z\xB4"), var_96_14.text)

																				var_96_9 = var_96_9 + var_96_2.y - 3
																			end

																			break
																		end
																	end

																	break
																end
															end
														end

														break
													end
												end
											end,
											[var_0_8("\xE9\xBF\xFAH\xFE\xA8", ",\x9Bڔ")] = function(arg_97_0)
												local var_97_0 = 0
												local var_97_1

												while true do
													if var_97_0 == 0 then
														local var_97_2 = 0

														while true do
															if var_97_2 == 0 then
																arg_97_0:damage_indicator()
																arg_97_0:center_indicators()

																break
															end
														end

														break
													end
												end
											end
										},
										[var_0_8("\xFA\xF4>7\xD0", "э\x9BL[\xB4G")] = {
											[var_0_8("\xF5r\xC9", "z\x93\x1D\xBF+")] = {
												[var_0_8("\xB0\xD1M\x1D", "\x1Eܰ>i\xBA\x9F\xEC")] = ui.get(var_27_11.reference.misc.override_fov),
												[var_0_8("\x84ؗ\xA0", "\xDD\xE8\xBD\xE5\xD0V\xB5\xD7")] = 0
											},
											[var_0_8("\x16\xBB\xFB\xD1", "NlԔ\xBC")] = {
												[var_0_8("7\x11\a6", "Z[ptB\x8C`\xDB")] = ui.get(var_27_11.reference.misc.override_zoom_fov),
												[var_0_8("\xC9R\x18\x1C", "d\xA57jl\x80\xC8")] = 0
											},
											[var_0_8("\xC9\xCA\"\xA7\xFA\xD89\xBC\xD1\xF4<\xB2\xD7\xC04\xA1", "ӥ\xABQ")] = function(arg_98_0)
												local var_98_0 = 0
												local var_98_1
												local var_98_2

												while true do
													if var_98_0 == 0 then
														var_98_1 = 0

														local var_98_3

														var_98_0 = 1
													end

													if var_98_0 == 1 then
														while true do
															if var_98_1 == 0 then
																local var_98_4 = 0

																while true do
																	if var_98_4 == 1 then
																		var_98_1 = 1

																		break
																	end

																	if var_98_4 == 0 then
																		if not ui.get(var_27_20.visuals.world.last_shot_marker) then
																			return
																		end

																		if main.visuals.logs.record.pos.x == 0 and main.visuals.logs.record.pos.y == 0 then
																			return
																		end

																		var_98_4 = 1
																	end
																end
															end

															if var_98_1 == 1 then
																local var_98_5 = var_27_6(renderer.world_to_screen(main.visuals.logs.record.pos.x, main.visuals.logs.record.pos.y, main.visuals.logs.record.pos.z))

																if var_98_5.x ~= 0 and var_98_5.y ~= 0 then
																	utilz.render:text(var_98_5, var_27_6(125, 255, 125), 1, "b", "+")
																end

																break
															end
														end

														break
													end
												end
											end,
											[var_0_8("\x00p\xD4\xCF\xD9\xCF\rc\xD7\xF5\xD5\xD3\x1C", "\xBCd\x15\xB2\xAA\xB7")] = function(arg_99_0)
												local var_99_0 = 0
												local var_99_1

												while true do
													if var_99_0 == 1 then
														local var_99_2 = client.current_threat()

														if player:is_valid(var_99_2) and var_0_11.band(entity.get_prop(var_27_11.local_player, var_0_8("s(V\x95\xBE\xCCy\x04", "\xAD\x1Ew0\xD3\xD2")), 1) == 1 and var_27_6(entity.get_prop(var_27_11.local_player, var_0_8("V\xE6/?X\xF8;)m\xDC55X\xD0-#", "Z;\xB9Y"))):length2d() >= 90 then
															local var_99_3 = 0
															local var_99_4
															local var_99_5
															local var_99_6
															local var_99_7
															local var_99_8

															while true do
																if var_99_3 == 0 then
																	var_99_4 = 0
																	var_99_5 = nil
																	var_99_3 = 1
																end

																if var_99_3 == 2 then
																	local var_99_9

																	while true do
																		if var_99_4 == 1 then
																			local var_99_10

																			var_99_7, var_99_10 = client.trace_bullet(var_27_11.local_player, var_99_5.x, var_99_5.y, var_99_5.z, var_99_6.x, var_99_6.y, var_99_6.z, false)

																			if var_27_11.cache.antiaim.ground_ticks > 2 and var_27_8:in_defensive() and var_99_10 > 0 then
																				utilz.render:box_3d(var_27_11.local_player, var_27_6(entity.get_origin(var_27_11.local_player)), player:get_simulated_origin(var_27_11.local_player, var_27_6(entity.get_origin(var_27_11.local_player)), entity.get_prop(var_27_11.local_player, var_0_8("\x1E\nw\x9BM\xA0\x14&", "\xC1sU\x11\xDD!")), 6), var_27_6(255, 255, 255))
																			end

																			break
																		end

																		if var_99_4 == 0 then
																			var_99_5 = player:get_simulated_origin(var_27_11.local_player, var_27_6(entity.get_origin(var_27_11.local_player)), entity.get_prop(var_27_11.local_player, var_0_8("M\xCF\\i7|G\xE3", "\x1D \x90:/[")), 14)
																			var_99_6 = var_27_6(entity.hitbox_position(var_99_7, 0))
																			var_99_4 = 1
																		end
																	end

																	break
																end

																if var_99_3 == 1 then
																	var_99_6 = nil
																	var_99_7 = nil
																	var_99_3 = 2
																end
															end
														end

														break
													end

													if var_99_0 == 0 then
														local var_99_11 = 0

														while true do
															if var_99_11 == 0 then
																if not ui.get(var_27_20.visuals.world.defensive_box) then
																	return
																end

																if not ui.get(var_27_11.reference.visuals.thirdperson[2]) then
																	return
																end

																var_99_11 = 1
															end

															if var_99_11 == 1 then
																var_99_0 = 1

																break
															end
														end
													end
												end
											end,
											[var_0_8("\xFEu\x0F\x0E\xA3\xD5\xE3~", "\xBC\x8D\x1Bn~\xCF")] = function(arg_100_0)
												local var_100_0 = 0
												local var_100_1

												while true do
													if var_100_0 == 1 then
														if client.current_threat() and entity.is_alive(client.current_threat()) then
															local var_100_2 = 0
															local var_100_3
															local var_100_4
															local var_100_5

															while true do
																if var_100_2 == 0 then
																	local var_100_6 = 0

																	while true do
																		if var_100_6 == 1 then
																			var_100_2 = 1

																			break
																		end

																		if var_100_6 == 0 then
																			var_100_3 = 0

																			local var_100_7

																			var_100_6 = 1
																		end
																	end
																end

																if var_100_2 == 1 then
																	local var_100_8

																	while true do
																		if var_100_3 == 1 then
																			if var_100_8.x ~= 0 and var_100_8.y ~= 0 then
																				renderer.line(var_100_1.x, var_100_1.y, var_100_8.x, var_100_8.y, 255, 255, 255, 75)
																			end

																			break
																		end

																		if var_100_3 == 0 then
																			local var_100_9 = var_27_6(entity.get_prop(client.current_threat(), var_0_8("\x80\tHr\xE7\xC6\f\x99!Qe\xEF\xC7\x1B\x841Wy", "i\xEDV>\x17\x84\x88")))

																			var_100_8 = var_27_6(renderer.world_to_screen(var_100_9.x, var_100_9.y, var_100_9.z))
																			var_100_3 = 1
																		end
																	end

																	break
																end
															end
														end

														break
													end

													if var_100_0 == 0 then
														local var_100_10 = 0
														local var_100_11

														while true do
															if var_100_10 == 0 then
																local var_100_12 = 0

																while true do
																	if var_100_12 == 1 then
																		var_100_0 = 1

																		break
																	end

																	if var_100_12 == 0 then
																		if not ui.get(var_27_20.visuals.world.snapline) then
																			return
																		end

																		var_100_1 = var_27_6(var_27_11.screen_size.x / 2, var_27_11.screen_size.y, 0)
																		var_100_12 = 1
																	end
																end

																break
															end
														end
													end
												end
											end,
											[var_0_8("\xB5H/Y\x1C\x0E\xBCL2r!\x12\xA1", "}\xD9)\\-C")] = function(arg_101_0)
												local var_101_0 = 0

												while true do
													if var_101_0 == 0 then
														if not ui.get(var_27_20.visuals.world.last_seen_box) then
															return
														end

														for iter_101_0, iter_101_1 in pairs(player.net_info.players_info) do
															if entity.is_dormant(iter_101_0) then
																local var_101_1 = 0
																local var_101_2
																local var_101_3
																local var_101_4
																local var_101_5
																local var_101_6
																local var_101_7

																while true do
																	if var_101_1 == 0 then
																		var_101_2 = 0

																		local var_101_8

																		var_101_1 = 1
																	end

																	if var_101_1 == 1 then
																		local var_101_9
																		local var_101_10

																		var_101_1 = 2
																	end

																	if var_101_1 == 3 then
																		while true do
																			if var_101_2 == 0 then
																				local var_101_11, var_101_12, var_101_13, var_101_14, var_101_15 = entity.get_bounding_box(iter_101_0)

																				if var_101_15 < 0.01 then
																					local var_101_16 = 0
																					local var_101_17
																					local var_101_18
																					local var_101_19

																					while true do
																						if var_101_16 == 1 then
																							local var_101_20

																							while true do
																								if var_101_17 == 0 then
																									local var_101_21 = 0

																									while true do
																										if var_101_21 == 1 then
																											var_101_17 = 1

																											break
																										end

																										if var_101_21 == 0 then
																											var_101_18 = iter_101_1.net_origin
																											var_101_20 = iter_101_1.simulated_origin
																											var_101_21 = 1
																										end
																									end
																								end

																								if var_101_17 == 1 then
																									if var_101_18.x ~= 0 and var_101_18.y ~= 0 and var_101_18.z ~= 0 and var_101_20.x ~= 0 and var_101_20.y ~= 0 and var_101_20.z ~= 0 then
																										local var_101_22 = 0
																										local var_101_23
																										local var_101_24

																										while true do
																											if var_101_22 == 1 then
																												utilz.render:text(var_27_6(var_101_24.x, var_101_24.y), var_27_6(255, 125, 125), 1, var_0_8("Z\xB0", ";9\xD4f?\xE3"), var_0_8("q\xE9l\x13=\xFBz\x02s", "g\x1D\x88\x1F"))
																												utilz.render:box_3d(iter_101_0, var_101_18, var_101_20, var_27_6(255, 125, 125))

																												break
																											end

																											if var_101_22 == 0 then
																												local var_101_25 = var_101_18:lerp(var_101_20, 0.33000001)

																												var_101_24 = var_27_6(renderer.world_to_screen(var_101_25.x, var_101_25.y, var_101_25.z + 100))
																												var_101_22 = 1
																											end
																										end
																									end

																									break
																								end
																							end

																							break
																						end

																						if var_101_16 == 0 then
																							var_101_17 = 0
																							var_101_18 = nil
																							var_101_16 = 1
																						end
																					end
																				end

																				break
																			end
																		end

																		break
																	end

																	if var_101_1 == 2 then
																		local var_101_26
																		local var_101_27

																		var_101_1 = 3
																	end
																end
															end
														end

														break
													end
												end
											end,
											[var_0_8("\x1F*\xDB:R\x178\xDF\x15@\x118", "&~N\xBAJ")] = function(arg_102_0)
												local var_102_0 = 0
												local var_102_1
												local var_102_2

												while true do
													if var_102_0 == 0 then
														var_102_1 = 0
														var_102_2 = nil
														var_102_0 = 1
													end

													if var_102_0 == 1 then
														while true do
															if var_102_1 == 0 then
																local var_102_3 = 0

																while true do
																	if var_102_3 == 0 then
																		if not ui.get(var_27_20.visuals.world.adaptive_fov) then
																			return
																		end

																		var_102_2 = var_27_6(entity.get_prop(var_27_11.local_player, var_0_8("\xCC\x7F<\x8FD\xA5\xC3S\x1C\x8FK\x8B\xC2I>\x93", "\xE4\xA1 J\xEA'"))):length2d()
																		var_102_3 = 1
																	end

																	if var_102_3 == 1 then
																		var_102_1 = 1

																		break
																	end
																end
															end

															if var_102_1 == 1 then
																arg_102_0.fov.lerp = utilz.math:fast_lerp(arg_102_0.fov.lerp, var_102_2 > 250 and 6 or 0, 0.1)

																if arg_102_0.fov.lerp ~= 0 then
																	ui.set(var_27_11.reference.misc.override_fov, ui.get(var_27_20.visuals.world.adaptive_fov_amount) + arg_102_0.fov.lerp)

																	break
																end

																if ui.get(var_27_20.visuals.world.adaptive_fov_amount) ~= ui.get(var_27_11.reference.misc.override_fov) then
																	ui.set(var_27_11.reference.misc.override_fov, ui.get(var_27_20.visuals.world.adaptive_fov_amount))
																end

																break
															end
														end

														break
													end
												end
											end,
											[var_0_8("?\x8A\x03\xB8\xF1\x951\xBF$\x8B\x05\xB8χ;\x96", "\xE0^\xE4jՐ\xE1T")] = function(arg_103_0)
												local var_103_0 = 0

												while true do
													if var_103_0 == 1 then
														if arg_103_0.zoom.lerp ~= 0 then
															ui.set(var_27_11.reference.misc.override_zoom_fov, arg_103_0.zoom.lerp)
														end

														break
													end

													if var_103_0 == 0 then
														if not ui.get(var_27_20.visuals.world.animate_zoom_fov) then
															return
														end

														arg_103_0.zoom.lerp = utilz.math:fast_lerp(arg_103_0.zoom.lerp, entity.get_prop(var_27_11.local_player, var_0_8("\xBD\xD7E\xE9\x12\x83\xEBH\xD0\x04\xB4", "aЈ'\xA0")) == 1 and ui.get(var_27_20.visuals.world.animate_zoom_fov_amount) + 1 or 0, 0.06999999999999318)
														var_103_0 = 1
													end
												end
											end,
											[var_0_8("\xE4,͂\\\x00", "[\x96I\xA3\xE69r")] = function(arg_104_0)
												local var_104_0 = 0
												local var_104_1

												while true do
													if var_104_0 == 0 then
														local var_104_2 = 0

														while true do
															if var_104_2 == 1 then
																local var_104_3 = 0

																while true do
																	if var_104_3 == 1 then
																		var_104_2 = 2

																		break
																	end

																	if var_104_3 == 0 then
																		arg_104_0:snapline()
																		arg_104_0:last_seen_box()

																		var_104_3 = 1
																	end
																end
															end

															if var_104_2 == 2 then
																arg_104_0:adaptive_fov()
																arg_104_0:animate_zoom_fov()

																break
															end

															if var_104_2 == 0 then
																arg_104_0:last_shot_marker()
																arg_104_0:defensive_box()

																var_104_2 = 1
															end
														end

														break
													end
												end
											end
										},
										[var_0_8("\\\xA8\xBCR\xF5\x19", "?.\xCD\xD26\x90k\xDE")] = function(arg_105_0)
											local var_105_0 = 0
											local var_105_1

											while true do
												if var_105_0 == 0 then
													local var_105_2 = 0

													while true do
														if var_105_2 == 0 then
															local var_105_3 = 0

															while true do
																if var_105_3 == 1 then
																	var_105_2 = 1

																	break
																end

																if var_105_3 == 0 then
																	arg_105_0:windows()
																	arg_105_0.screen:render()

																	var_105_3 = 1
																end
															end
														end

														if var_105_2 == 1 then
															arg_105_0.world:render()

															break
														end
													end

													break
												end
											end
										end
									},
									[var_0_8("\xFD%\xE7D", "\xBC\x90L\x94'")] = {
										[var_0_8("\x82Gz\xA6M\x00", "5\xE5+\x15\xC4,lB")] = {
											[var_0_8("09\x16\xAB'4\x10\x9A !\x05", "\xC5SUw")] = {
												"⚡",
												"⚡h",
												"⚡hy",
												"⚡hyp",
												"⚡hype",
												"⚡hyper",
												"⚡hypers",
												"⚡hyperst",
												"⚡hypersto",
												"⚡hypersto",
												"⚡hyperston",
												"⚡hyperstone",
												"⚡hyperstone",
												"⚡hyperston",
												"⚡hypersto",
												"⚡hyperst",
												"⚡hypers",
												"⚡hyper",
												"⚡hype",
												"⚡hyp",
												"⚡hy",
												"⚡h",
												"⚡"
											},
											[var_0_8("L\xF6\x1F9[\xFB\x19\b[\xF3\x132", "W/\x9A~")] = 0,
											[var_0_8("%}\xC9\xDF\xED\xDF\"t\xC0\xC8\xD3\xCD", "\xB4K\x18\xAC\xBB\xB2")] = false,
											[var_0_8("\xCF\xD8\xF6\x17C7\xED\x02\xC2\xDF\xE0<o)\xF6\x1F\xD7\xD1", "p\xA3\xB9\x85c\x1CD\x99")] = 35,
											[var_0_8("\xA7Q\xEE۔B\xF9ǤW\xF5߲", "\xAB\xCB4\x9C")] = 0,
											[var_0_8("\xBB\xCE|\xA1>\x88\xAB\xA5\x85\xD9i\xA3+\x87\xB8", "\xC0ڪ\x1D\xD1J\xE1\xDD")] = function(arg_106_0)
												local var_106_0 = 0
												local var_106_1

												while true do
													if var_106_0 == 2 then
														if arg_106_0.lerp_velocity ~= 0 then
															ui.set(var_27_11.reference.misc.strafe_smooth, var_27_10(arg_106_0.last_strafe_smooth / (0.08 * arg_106_0.lerp_velocity), arg_106_0.last_strafe_smooth / 2, 100))

															break
														end

														if arg_106_0.last_strafe_smooth ~= ui.get(var_27_11.reference.misc.strafe_smooth) then
															ui.set(var_27_11.reference.misc.strafe_smooth, arg_106_0.last_strafe_smooth)
														end

														break
													end

													if var_106_0 == 1 then
														local var_106_2 = 0

														while true do
															if var_106_2 == 0 then
																ui.set(var_27_11.reference.misc.strafe, var_106_1 > 5)

																arg_106_0.lerp_velocity = utilz.math:fast_lerp(arg_106_0.lerp_velocity, var_106_1 > 5 and var_106_1 / 20 or 0, 0.33)
																var_106_2 = 1
															end

															if var_106_2 == 1 then
																var_106_0 = 2

																break
															end
														end
													end

													if var_106_0 == 0 then
														local var_106_3 = 0
														local var_106_4

														while true do
															if var_106_3 == 0 then
																local var_106_5 = 0

																while true do
																	if var_106_5 == 1 then
																		var_106_0 = 1

																		break
																	end

																	if var_106_5 == 0 then
																		if not ui.get(var_27_20.misc.global.adaptive_strafe) then
																			local var_106_6 = 0
																			local var_106_7

																			while true do
																				if var_106_6 == 0 then
																					local var_106_8 = 0

																					while true do
																						if var_106_8 == 0 then
																							local var_106_9 = 0
																							local var_106_10

																							while true do
																								if var_106_9 == 0 then
																									local var_106_11 = 0

																									while true do
																										if var_106_11 == 0 then
																											if arg_106_0.last_strafe_smooth ~= ui.get(var_27_11.reference.misc.strafe_smooth) then
																												ui.set(var_27_11.reference.misc.strafe_smooth, arg_106_0.last_strafe_smooth)
																											end

																											return
																										end
																									end

																									break
																								end
																							end
																						end
																					end

																					break
																				end
																			end
																		end

																		var_106_1 = var_27_6(entity.get_prop(var_27_11.local_player, var_0_8("\x8E\xE3M\x05\xCCl+\xEE\xB5\xD9W\x0F\xCCD=\xE4", "\x9D\xE3\xBC;`\xAF-I"))):length2d()
																		var_106_5 = 1
																	end
																end

																break
															end
														end
													end
												end
											end,
											[var_0_8("\xB4\xC3\xDB\x1A\"\xBE\xD3", "Qߪ\xB7v")] = function(arg_107_0)
												local var_107_0 = 0
												local var_107_1

												while true do
													if var_107_0 == 0 then
														local var_107_2 = 0

														while true do
															if var_107_2 == 0 then
																if not ui.get(var_27_20.misc.global.killsay) then
																	return
																end

																if arg_107_0.need_killsay then
																	local var_107_3 = 0
																	local var_107_4

																	while true do
																		if var_107_3 == 0 then
																			local var_107_5 = 0

																			while true do
																				if var_107_5 == 0 then
																					client.exec(var_0_8("5@\xB5\xFB\xA8", "qF!\xCCۙR"))

																					arg_107_0.need_killsay = false

																					break
																				end
																			end

																			break
																		end
																	end
																end

																break
															end
														end

														break
													end
												end
											end,
											[var_0_8("\xF2\x8E>2\xEA\xB1\xF6", "Б\xE2_\\\x9E")] = function(arg_108_0, arg_108_1)
												local var_108_0 = 0
												local var_108_1

												while true do
													if var_108_0 == 0 then
														local var_108_2 = 0
														local var_108_3

														while true do
															if var_108_2 == 0 then
																local var_108_4 = 0

																while true do
																	if var_108_4 == 0 then
																		if arg_108_1.chokedcommands ~= 0 then
																			return
																		end

																		var_108_1 = math.floor(globals.curtime() * 2)
																		var_108_4 = 1
																	end

																	if var_108_4 == 1 then
																		var_108_0 = 1

																		break
																	end
																end

																break
															end
														end
													end

													if var_108_0 == 1 then
														if arg_108_0.clantag_time ~= var_108_1 then
															local var_108_5 = 0
															local var_108_6

															while true do
																if var_108_5 == 0 then
																	local var_108_7 = 0

																	while true do
																		if var_108_7 == 0 then
																			client.set_clan_tag(ui.get(var_27_20.misc.global.clantag) and arg_108_0.clantag_str[var_108_1 % #arg_108_0.clantag_str + 1] or "")

																			arg_108_0.clantag_time = var_108_1

																			break
																		end
																	end

																	break
																end
															end
														end

														break
													end
												end
											end,
											[var_0_8("\xB8\xE0\xCEX\xD0\xF9\xAE\x1C\xBA\xE4\xCF", "xށ\xBD,\x8F\x95\xCF")] = function(arg_109_0, arg_109_1)
												local var_109_0 = 0
												local var_109_1
												local var_109_2

												while true do
													if var_109_0 == 0 then
														if not ui.get(var_27_20.misc.global.fast_ladder) then
															return
														end

														var_109_1 = entity.get_prop(var_27_11.local_player, var_0_8("\x89.0\xBE\xDCNM\xA1\x94\x14", "\xD8\xE4q}Ѫ+\x19")) == 9
														var_109_0 = 1
													end

													if var_109_0 == 3 then
														if arg_109_1.in_forward == 1 then
															arg_109_1.yaw = arg_109_1.yaw + (arg_109_1.sidemove < 0 and 90 or arg_109_1.sidemove > 0 and -1 or 0)
														elseif arg_109_1.in_back == 1 then
															arg_109_1.yaw = arg_109_1.yaw + (arg_109_1.sidemove > 0 and 90 or arg_109_1.sidemove < 0 and -1 or 0)
														end

														arg_109_1.in_moveright = arg_109_1.in_forward == 1 and 1 or 0
														var_109_0 = 4
													end

													if var_109_0 == 2 then
														if arg_109_1.in_speed == 1 or arg_109_1.in_duck == 1 or not var_109_2 then
															return
														end

														if arg_109_1.sidemove == 0 then
															arg_109_1.yaw = arg_109_1.yaw + 45
														end

														var_109_0 = 3
													end

													if var_109_0 == 4 then
														arg_109_1.in_moveleft = arg_109_1.in_forward == 1 and 0 or 1

														break
													end

													if var_109_0 == 1 then
														if not var_109_1 then
															return
														end

														var_109_2 = arg_109_1.in_forward == 1 or arg_109_1.in_back == 1 or arg_109_1.in_left == 1 or arg_109_1.in_right == 1
														var_109_0 = 2
													end
												end
											end,
											[var_0_8("\xF0\xF4QQ", "\x1E\x99\x9A8%\x12")] = function(arg_110_0, arg_110_1)
												local var_110_0 = 0
												local var_110_1

												while true do
													if var_110_0 == 0 then
														local var_110_2 = 0

														while true do
															if var_110_2 == 0 then
																local var_110_3 = 0

																while true do
																	if var_110_3 == 1 then
																		var_110_2 = 1

																		break
																	end

																	if var_110_3 == 0 then
																		arg_110_0:adaptive_strafe()
																		arg_110_0:killsay()

																		var_110_3 = 1
																	end
																end
															end

															if var_110_2 == 1 then
																arg_110_0:clantag(arg_110_1)
																arg_110_0:fast_ladder(arg_110_1)

																break
															end
														end

														break
													end
												end
											end
										},
										[var_0_8("\x1A\xB8\xFA\t\x04\x1E\xB6\xFA\x01:\x13\xBD\xE4", "[}ٗl")] = function(arg_111_0)
											if ui.get(var_27_20.misc.game.console_filter) then
												local var_111_0 = 0

												while true do
													if var_111_0 == 0 then
														if cvar.con_filter_enable:get_string() ~= "1" then
															cvar.con_filter_enable:set_string("1")
														end

														if cvar.con_filter_text_out:get_string() ~= var_0_8("\xFD\x1B\xA2g\xDF\xFE\x17\xB3x\xDF\xEE\x14", "\xBE\x99s\xC6\x10") then
															cvar.con_filter_text_out:set_string(var_0_8(">s\xAE\x90;|\xAE\x922z\xBD\x80", "\xE7Z\x1B\xCA"))
														end

														var_111_0 = 1
													end

													if var_111_0 == 1 then
														if cvar.con_filter_text:get_string() ~= var_0_8("\x85\x93Y\xA6\\\x8E\x9CU\xACK\x88\x93\\\xAC\x1E\xD0", ">\xE1\xE48\xC2") then
															cvar.con_filter_text:set_string(var_0_8("\x12\xAE\xB8)vZ\x0E\xB4\xB78}B\x12\xB7\xF9|", "5v\xD9\xD9M\x14"))
														end

														break
													end
												end
											else
												local var_111_1 = 0

												while true do
													if var_111_1 == 1 then
														if cvar.con_filter_text:get_string() ~= "" then
															cvar.con_filter_text:set_string("")
														end

														break
													end

													if var_111_1 == 0 then
														local var_111_2 = 0

														while true do
															if var_111_2 == 1 then
																var_111_1 = 1

																break
															end

															if var_111_2 == 0 then
																if cvar.con_filter_enable:get_string() ~= "0" then
																	cvar.con_filter_enable:set_string("0")
																end

																if cvar.con_filter_text_out:get_string() ~= "" then
																	cvar.con_filter_text_out:set_string("")
																end

																var_111_2 = 1
															end
														end
													end
												end
											end

											local var_111_3 = var_27_6(ui.get(var_27_20.misc.game.viewmodel_x) / 10, ui.get(var_27_20.misc.game.viewmodel_y) / 10, ui.get(var_27_20.misc.game.viewmodel_z) / 10)

											if client.get_cvar(var_0_8("\xBF\x16\xE1\xC9\"\xA6\x1B\xE1\xD2\x10\xA6\x19\xE2\xCD*\xBD \xFC", "O\xC9\x7F\x84\xBE")) ~= var_111_3.x then
												client.set_cvar(var_0_8(">\x1D\xEC\xDE%\x1B\xED\xCC$+\xE6\xCF.\a\xEC\xDD\x17\f", "\xA9Ht\x89"), var_111_3.x)
											end

											if client.get_cvar(var_0_8("os̱tuͣuEƠ\x7Fi̲Fc", "\xC6\x19\x1A\xA9")) ~= var_111_3.y then
												client.set_cvar(var_0_8("_z\xD81\x8A^\x7FzEL\xD2 \x81B~kvj", "\x1F)\x13\xBDF\xE71\x1B"), var_111_3.y)
											end

											if client.get_cvar(var_0_8("\xA1\xDAT\xF1\xBA\xDCU\xE3\xBB\xEC^\xE0\xB1\xC0T\xF2\x88\xC9", "\x86׳1")) ~= var_111_3.z then
												client.set_cvar(var_0_8("\xF7\xFDS\xF1X\x1C\xE5\xF1Z\xD9Z\x15\xE7\xE7S\xF2j\t", "s\x81\x946\x865"), var_111_3.z)
											end

											local var_111_4 = ui.get(var_27_20.misc.game.aspect_ratio) / 100

											if client.get_cvar(var_0_8("\xFB\xB8QX\xC8\r\x10\xFD\xB8BJ\xCC\x01\x1C", "s\x89\xE70+\xB8h")) ~= var_111_4 then
												client.set_cvar(var_0_8("\xCB\xD6\x1B\xF0\xB9\xA5<\xCD\xFB\x1B\xF7\xA0\xAF", "_\xB9\x89z\x83\xC9\xC0"), var_111_4)
											end

											local var_111_5 = ui.get(var_27_20.misc.game.thirdperson_distance)

											if client.get_cvar(var_0_8("u7\xCA,,r3\xC6\x1F!\x7F%\xD3", "E\x16V\xA7s")) ~= var_111_5 then
												client.set_cvar(var_0_8("[\x85J\xBEL#]\x85K\x85L4L", "G8\xE4'\xE1%"), var_111_5)
											end

											if ui.get(var_27_20.misc.game.sunset_mode) == var_0_8("\x94\xE8\xF7(\xF8\xE1'\xB4", "BЁ\x84I\x9A\x8D") and client.get_cvar(var_0_8("IS\xE9\xFEYR\xE9\xEFEK\xE9\xF2\\Z\xC4\xEFC[\xD3", "\x9D*?\xB6")) ~= 0 then
												client.set_cvar(var_0_8("\xD82\x16\xFF\xDC\xD6\x01;\xF3\xDB\xE41?\xF9\xDD\xC97-\xF9", "\xAF\xBB^I\x9C"), 0)
											elseif ui.get(var_27_20.misc.game.sunset_mode) == var_0_8("\x02:I!\x0E/\xD4", "\xA0F_/@{C") then
												local var_111_6 = 0
												local var_111_7

												while true do
													if var_111_6 == 0 then
														local var_111_8 = 0

														while true do
															if var_111_8 == 0 then
																local var_111_9 = 0

																while true do
																	if var_111_9 == 1 then
																		var_111_8 = 1

																		break
																	end

																	if var_111_9 == 0 then
																		if client.get_cvar(var_0_8("\xDDVK2\xCDWK#\xD1NK>\xC8_f#\xD7^q", "Q\xBE:\x14")) ~= 1 then
																			client.set_cvar(var_0_8("OA\x89t\x90$`!CY\x89x\x95,M!EI\xB3", "S,-\xD6\x17\xE3I?"), 1)
																		end

																		if client.get_cvar(var_0_8("\xF6\xB6y\xBD3\xF8\x85T\xB14ʢ", "@\x95\xDA&\xDE")) ~= 50 then
																			client.set_cvar(var_0_8("\x19\xAB\xF5\xD3\t\xAA\xF5\xC2\x15\xB3\xF5\xC8", "\xB0zǪ"), 50)
																		end

																		var_111_9 = 1
																	end
																end
															end

															if var_111_8 == 1 then
																if client.get_cvar(var_0_8("\x11\a\x8F\xD3\"&-\x19\xBF\xC4\x0E2", "KrkаQ")) ~= 43 then
																	client.set_cvar(var_0_8("\xFA'\x16v\xEA&\x16g\xF6?\x16l", "\x15\x99KI"), 43)
																end

																break
															end
														end

														break
													end
												end
											elseif ui.get(var_27_20.misc.game.sunset_mode) == var_0_8(" \x1D[\xF7\xA0U\f", "&is-\x92\xD2") then
												local var_111_10 = 0
												local var_111_11

												while true do
													if var_111_10 == 0 then
														local var_111_12 = 0

														while true do
															if var_111_12 == 1 then
																if client.get_cvar(var_0_8("\x7FB\xC9\xE3\x15J$nA\xE2\xDF\x1F", "{\x1C.\x96\x80f'")) ~= 100 then
																	client.set_cvar(var_0_8("\x06E\"T\b\x84\x04g\n]\"N", "\x15e)}7{\xE9["), 100)
																end

																break
															end

															if var_111_12 == 0 then
																if client.get_cvar(var_0_8("\x01\x1A3u \x0F)\x1Ey'=\x19\x1As!\x10\x1F\bs", "Sbvl\x16")) ~= 1 then
																	client.set_cvar(var_0_8("J\xE7F.\xB6\x89\x1C[\xE4m\x12\xAA\x92&[\xF9p)\xA0", "C)\x8B\x19M\xC5\xE4"), 1)
																end

																if client.get_cvar(var_0_8("\xEB\xA2\xF1)E\xE5׼\xC1>i\xF0", "\x88\x88ήJ6")) ~= 30 then
																	client.set_cvar(var_0_8("'\xFF\xB9\x86@\xA9\x846\xFC\x92\xBAK", "\xDBD\x93\xE6\xE53\xC4"), 30)
																end

																var_111_12 = 1
															end
														end

														break
													end
												end
											end

											if ui.get(var_27_20.ragebot.exploits.reduce_register_shot_delay) then
												local var_111_13 = 0
												local var_111_14
												local var_111_15

												while true do
													if var_111_13 == 0 then
														local var_111_16 = 0

														while true do
															if var_111_16 == 0 then
																local var_111_17 = math.ceil(client.real_latency() * 1000 * 0.82)

																var_111_15 = var_111_17 >= 30 and var_111_17 or 0
																var_111_16 = 1
															end

															if var_111_16 == 1 then
																var_111_13 = 1

																break
															end
														end
													end

													if var_111_13 == 1 then
														if var_111_15 == 0 then
															if client.get_cvar(var_0_8("\x81\xE7\x91\xF0\x00=\x81\xE0\x91\xF0\x03 \x90\xEE\xAD\xE7\x05=\x8C", "R\xE2\x8BΓl")) ~= 0 then
																client.set_cvar(var_0_8("\xF2\nr\xB2\xC0\xFE\x05F\x8E\xCF\xFE\x14_\xB4\xCF\xE5\x0FB\xBF", "\xAC\x91f-\xD1"), 0)
															end

															break
														end

														local var_111_18 = 0
														local var_111_19

														while true do
															if var_111_18 == 0 then
																local var_111_20 = 0

																while true do
																	if var_111_20 == 0 then
																		if client.get_cvar(var_0_8("\xF7\x013C\x87q\xF7\x06\bR\x82x\xE02\x01A\x93A\xF9\x1E3T\x83l\xF1\f\bM\x84z\xF1", "\x1E\x94ml \xEB")) ~= 1 then
																			client.set_cvar(var_0_8("\x17K.\\\x18H\x12T\x10U\x18Y\x00x\x1C^\fx\x1CL+S\x19M\x11F\x15R\x1BC\x14", "?t'q"), 1)
																		end

																		if var_111_15 >= 30 then
																			if client.get_cvar(var_0_8(";\\\xF8\xEF\x1C'\xAB3o\xC4\xE3\x02:\xAD;D\xCE\xE3\x1E\x17\xA9<Z\xD2\xFF\x04%\xAD6D\xF8\xE1\x19&\x977V\xC1\xFF\x15<", "\xC8X0\xA7\x8CpH")) ~= 25 then
																				client.set_cvar(var_0_8("\xC1R\x17\xA8\xEE\xCD]#\x94\xE1\xCDL:\xAE\xE1\xD6W'\xA5\xDD\xC3Z\"\xBE\xF1\xD6S-\xA5\xF6\xFDS!\xA5\xDD\xCDX.\xB8\xE7\xD6", "\x82\xA2>H\xCB"), 25)
																			end

																			break
																		end

																		if var_111_15 >= 50 then
																			if client.get_cvar(var_0_8("\xA0\xBB\x82s\x8B\x8F\xEC\xF6\x9C\xB4\xB2b\x95\x85\xEC骸\xB3O\x86\x84\xE5谣\xB0u\x89\x94\xD0𪹂\x7F\x81\x86\xFC\xF8\xB7", "\x9D\xC3\xD7\xDD\x10\xE7\xE0\x8F")) ~= 45 then
																				client.set_cvar(var_0_8("|\xD54\x8F\xEFp\xDA\x00\xB3\xE0p\xCB\x19\x89\xE0k\xD0\x04\x82\xDC~\xDD\x01\x99\xF0k\xD4\x0E\x82\xF7@\xD4\x02\x82\xDCp\xDF\r\x9F\xE6k", "\x83\x1F\xB9k\xEC"), 45)
																			end

																			break
																		end

																		if var_111_15 >= 90 then
																			if client.get_cvar(var_0_8("\xA8\xA7u'\xA7\xA4I/\x94\xA8E6\xB9\xAEI0\xA2\xA4D\x1B\xAA\xAF@1\xB8\xBFG!\xA5\xBFu)\xA2\xA5u+\xAD\xADY!\xBF", "D\xCB\xCB*")) ~= 55 then
																				client.set_cvar(var_0_8("@[J\xDAOXv\xD2|Tz\xCBQRv\xCDJX{\xE6BS\x7F\xCCPCx\xDCMCJ\xD4JYJ\xD6EQf\xDCW", "\xB9#7\x15"), 55)
																			end

																			break
																		end

																		if var_111_15 >= 120 then
																			if client.get_cvar(var_0_8("\xB0\xF5\x80\x87\xBF\xF6\xBC\x8F\x8C\xFA\xB0\x96\xA1\xFC\xBC\x90\xBA\xF6\xB1\xBB\xB2\xFD\xB5\x91\xA0\xED\xB2\x81\xBD퀉\xBA\xF7\x80\x8B\xB5\xFF\xAC\x81\xA7", "\xE4ә\xDF")) ~= 75 then
																				client.set_cvar(var_0_8("W\xE3g>6\tW\xE4g>5\x14F\xEA[)3\tZ\xD0Y90\x13G\xFBU84\x12k\xE2Q3\x05\tR\xE9K8.", "f4\x8F8]Z"), 75)
																			end

																			break
																		end

																		if var_111_15 >= 150 and client.get_cvar(var_0_8("E\x1B\x9F+\xE9I\x14\xAB\x17\xE6I\x05\xB2-\xE6R\x1E\xAF&\xDAG\x13\xAA=\xF6R\x1A\xA5&\xF1y\x1A\xA9&\xDAI\x11\xA6;\xE0R", "\x85&w\xC0H")) ~= 90 then
																			client.set_cvar(var_0_8("\xF4\xADK\xF8\xFB\xAEw\xF0Ȣ{\xE9\xE5\xA4w\xEF\xFE\xAEz\xC4\xF6\xA5~\xEE\xE4\xB5y\xFE\xF9\xB5K\xF6\xFE\xAFK\xF4\xF1\xA7g\xFE\xE3", "\x9B\x97\xC1\x14"), 90)
																		end

																		break
																	end
																end

																break
															end
														end

														break
													end
												end
											else
												local var_111_21 = 0
												local var_111_22

												while true do
													if var_111_21 == 0 then
														local var_111_23 = 0

														while true do
															if var_111_23 == 1 then
																if client.get_cvar(var_0_8("\xE3M\xD5\b,\xB0;\xEB~\xE9\x042\xAD=\xE3U\xE3\x04.\x809\xE4K\xFF\x184\xB2=\xEEU\xD5\x06)\xB1\a\xEFG\xEC\x18%\xAB", "X\x80!\x8Ak@\xDF")) ~= 10 then
																	client.set_cvar(var_0_8("\xC2\xFEJv\xA1t\xED\xCA\xCDvz\xBFi\xEB\xC2\xE6|z\xA3D\xEF\xC5\xF8`f\xB9v\xEB\xCF\xE6Jx\xA4u\xD1\xCE\xF4sf\xA8o", "\x8E\xA1\x92\x15\x15\xCD\x1B"), 10)
																end

																break
															end

															if var_111_23 == 0 then
																local var_111_24 = 0

																while true do
																	if var_111_24 == 0 then
																		if client.get_cvar(var_0_8("-\xA8?Mw!\xA7\vqx!\xB6\x12Kx:\xAD\x0F@", "\x1BN\xC4`.")) ~= 1 then
																			client.set_cvar(var_0_8("\xE9\xF7\x8D\xBBvKO\xE1ı\xB7hVI\xE9ﻷt", ",\x8A\x9B\xD2\xD8\x1A$"), 1)
																		end

																		if client.get_cvar(var_0_8("\xB8A\x86Y\xF1\xB4N\xB2^\xEF\xB2K\xADe\xF0\xBAU\x86W\xEE\x84Y\xB1H\xF8\xBAI\xB4U\xF9\xBE", "\x9D\xDB-\xD9:")) ~= 0 then
																			client.set_cvar(var_0_8("\xB3\xB1\t\xD6\xF2\xBF\xBE=\xD1칻\"\xEA\xF3\xB1\xA5\t\xD8폩>\xC7\xFB\xB1\xB9;\xDA\xFA\xB5", "\x9E\xD0\xDDV\xB5"), 0)
																		end

																		var_111_24 = 1
																	end

																	if var_111_24 == 1 then
																		var_111_23 = 1

																		break
																	end
																end
															end
														end

														break
													end
												end
											end
										end
									}
								})

								local var_27_26 = {
									[var_0_8("\x1F\xF4C\x10\x1F\xED\xD9\x00\xC5\x7F\f\x17\xF4\xCD\x1E\xFE", "\xACp\x9A\x1Ccz\x99")] = function(arg_112_0)
										local var_112_0 = 0

										while true do
											if var_112_0 == 1 then
												local var_112_1 = 0
												local var_112_2

												while true do
													if var_112_1 == 0 then
														local var_112_3 = 0

														while true do
															if var_112_3 == 0 then
																main.antiaim:override(arg_112_0)
																main.misc.global:init(arg_112_0)

																var_112_3 = 1
															end

															if var_112_3 == 1 then
																var_112_0 = 2

																break
															end
														end

														break
													end
												end
											end

											if var_112_0 == 0 then
												if not player:is_valid(var_27_11.local_player) then
													return
												end

												main.ragebot:init(arg_112_0)

												var_112_0 = 1
											end

											if var_112_0 == 2 then
												local var_112_4 = 0
												local var_112_5

												while true do
													if var_112_4 == 0 then
														local var_112_6 = 0

														while true do
															if var_112_6 == 1 then
																var_112_0 = 3

																break
															end

															if var_112_6 == 0 then
																main.misc:game_commands()
																var_27_8:allow_unsafe_charge(ui.get(var_27_20.ragebot.exploits.allow_unsafe_charge))

																var_112_6 = 1
															end
														end

														break
													end
												end
											end

											if var_112_0 == 3 then
												var_27_8:force_reload_exploits(ui.get(var_27_20.ragebot.exploits.airlag))

												break
											end
										end
									end,
									[var_0_8("\xC4\xF9\x9F\f\xDE\xF9\x9F\x1D\xC4\xFA\xAD\x1F\xC5\xF3", "~\xAB\x97\xC0")] = function(arg_113_0)
										if not player:is_valid(entity.get_local_player()) then
											return
										end

										if not var_27_11.local_player or var_27_11.local_player ~= entity.get_local_player() then
											var_27_11.local_player = entity.get_local_player()
										end

										if not var_27_11.weapon or var_27_11.weapon ~= entity.get_player_weapon(var_27_11.local_player) then
											var_27_11.weapon = entity.get_player_weapon(var_27_11.local_player)
										end

										main.ragebot:init_predict(arg_113_0)
										player.net_info:store()
									end,
									[var_0_8("1\x10\xC6\x12\x02\xEEf+\x0E\xFD\x1D\x13\xFFf;\x10\xFD", "9^~\x99|g\x9A")] = function()
										player.net_info:collect()
									end,
									[var_0_8("\x18\xC9v\t\xD7H\x19\xD3v\f\xDF", "!w\xA7)y\xB6")] = function()
										var_27_25()
									end,
									[var_0_8("H\xBA\x04F\xAAZ\x12,", "X'\xD4[6\xCB3|")] = function()
										local var_116_0 = 0
										local var_116_1

										while true do
											if var_116_0 == 0 then
												local var_116_2 = 0

												while true do
													if var_116_2 == 0 then
														if not player:is_valid(var_27_11.local_player) then
															return
														end

														main.visuals:render()

														break
													end
												end

												break
											end
										end
									end,
									[var_0_8("#\xA2\x8B\x8Br\xC3\xF7*\xA5\xA6\x8F", "\xA8L\xCC\xD4\xEA\x1B\xAE")] = function(arg_117_0)
										local var_117_0 = 0
										local var_117_1
										local var_117_2

										while true do
											if var_117_0 == 0 then
												local var_117_3 = 0

												while true do
													if var_117_3 == 0 then
														var_117_1 = 0
														var_117_2 = nil
														var_117_3 = 1
													end

													if var_117_3 == 1 then
														var_117_0 = 1

														break
													end
												end
											end

											if var_117_0 == 1 then
												while true do
													if var_117_1 == 0 then
														var_117_2 = main.visuals.logs.record
														var_117_2.hc, var_117_2.hg, var_117_2.pdmg, var_117_2.bt, var_117_2.acc, var_117_2.hp, var_117_2.ext, var_117_2.lc, var_117_2.pos = arg_117_0.hit_chance, main.visuals.logs.hitgroups[arg_117_0.hitgroup + 1] or "?", arg_117_0.damage, toticks(arg_117_0.backtrack), var_0_21(arg_117_0.boosted), var_0_21(arg_117_0.high_priority), var_0_21(arg_117_0.extrapolated), var_0_21(arg_117_0.teleported), var_27_6(arg_117_0.x, arg_117_0.y, arg_117_0.z)
														var_117_1 = 1
													end

													if var_117_1 == 1 then
														client.log(("[~] Fired %s in the %s [hc:%.2f, pdmg:%d, acc:%s, hp:%s, ext:%s, lc:%s]"):format(entity.get_player_name(arg_117_0.target), main.visuals.logs.hitgroups[arg_117_0.hitgroup + 1] or "?", math.floor(var_117_2.hc) / 100, arg_117_0.damage, var_117_2.acc, var_117_2.hp, var_117_2.ext, var_117_2.lc))

														main.visuals.logs.fired = true

														break
													end
												end

												break
											end
										end
									end,
									[var_0_8("\x83\n\fE\x00\xEBq\x84\r'", ".\xECdS$i\x86")] = function(arg_118_0)
										local var_118_0 = 0
										local var_118_1

										while true do
											if var_118_0 == 0 then
												local var_118_2 = 0

												while true do
													if var_118_2 == 0 then
														local var_118_3 = 0

														while true do
															if var_118_3 == 1 then
																var_118_2 = 1

																break
															end

															if var_118_3 == 0 then
																client.log(("[+] Hit %s in the %s for %d damage (%d health remaining)"):format(entity.get_player_name(arg_118_0.target), main.visuals.logs.hitgroups[arg_118_0.hitgroup + 1 + 0] or "?", arg_118_0.damage, entity.get_prop(arg_118_0.target, var_0_8("4Ŏ\xA8\x84\x0E5\xEE\x8F", "oY\x9A\xE7\xE0\xE1"))))
																table.insert(main.visuals.logs.stack, 1, {
																	[var_0_8("\xE9\xDF\x1E\xB1", "\xB1\x9D\xBAf\xC5L\x99\xBC")] = ("Hit %s in the %s for %d damage (%d health remaining)"):format(entity.get_player_name(arg_118_0.target), main.visuals.logs.hitgroups[arg_118_0.hitgroup + 1] or "?", arg_118_0.damage, entity.get_prop(arg_118_0.target, var_0_8("\xAF\x81)\x87\xA7\xBF,\xBB\xAA", "\xCF\xC2\xDE@"))),
																	[var_0_8("\x1Ay\xC7H\x89", "\xB3{\x15\xB7 \xE8")] = 1,
																	[var_0_8("\xD2*\xC18\xA1", "b\xA6C\xAC]\xD3")] = 3.5
																})

																var_118_3 = 1
															end
														end
													end

													if var_118_2 == 1 then
														main.visuals.logs.missed = false

														break
													end
												end

												break
											end
										end
									end,
									[var_0_8("\xE8\xED\xE8\xD4\vG\xDD\xEA\xEA\xC4\xC6", "\x82\x87\x83\xB7\xB5b*")] = function(arg_119_0)
										client.log(("[x] Missed %s in the %s for %d damage with hc %.2f (reason: %s)"):format(entity.get_player_name(arg_119_0.target), main.visuals.logs.hitgroups[arg_119_0.hitgroup + 1] or "?", main.visuals.logs.record.pdmg, math.floor(arg_119_0.hit_chance) / 100, arg_119_0.reason))
										table.insert(main.visuals.logs.stack, 1, {
											[var_0_8("׳#\xF7", "@\xA3\xD6[\x83")] = ("Missed %s in the %s for %d damage with hc %.2f (reason: %s)"):format(entity.get_player_name(arg_119_0.target), main.visuals.logs.hitgroups[arg_119_0.hitgroup + 1] or "?", main.visuals.logs.record.pdmg, math.floor(arg_119_0.hit_chance) / 100, arg_119_0.reason),
											[var_0_8("\x10#\b>>", "_qOxV")] = 1,
											[var_0_8("\xBF\xFD-\xB5\x94", "\xA9˔@\xD0\xE6m_")] = 3.5
										})

										main.visuals.logs.missed = true
									end,
									[var_0_8("\xC7\x199\xA2&\x1A%\xE3\xDA(\x02\xB7+\x0F4", "\x86\xA8wf\xD2J{\\")] = function(arg_120_0)
										local var_120_0 = 0
										local var_120_1
										local var_120_2
										local var_120_3

										while true do
											if var_120_0 == 0 then
												var_120_1 = 0
												var_120_2 = nil
												var_120_0 = 1
											end

											if var_120_0 == 1 then
												local var_120_4

												while true do
													if var_120_1 == 0 then
														local var_120_5 = 0
														local var_120_6

														while true do
															if var_120_5 == 0 then
																local var_120_7 = 0

																while true do
																	if var_120_7 == 1 then
																		var_120_1 = 1

																		break
																	end

																	if var_120_7 == 0 then
																		if not arg_120_0.userid or not arg_120_0.attacker then
																			return
																		end

																		var_120_2, var_120_4 = client.userid_to_entindex(arg_120_0.userid), client.userid_to_entindex(arg_120_0.attacker)
																		var_120_7 = 1
																	end
																end

																break
															end
														end
													end

													if var_120_1 == 1 then
														main.misc.global.need_killsay = var_120_4 == var_27_11.local_player and entity.is_enemy(var_120_2)

														if var_120_2 and player.net_info.players_info[var_120_2] then
															player.net_info.players_info[var_120_2] = nil
														end

														break
													end
												end

												break
											end
										end
									end,
									[var_0_8("\xA4\x00#^\xB9\v\x12X\xAF\v#M\xA3\x1C\x13N\xA5", "9\xCBn|")] = function(arg_121_0)
										local var_121_0 = 0
										local var_121_1

										while true do
											if var_121_0 == 0 then
												local var_121_2 = 0

												while true do
													if var_121_2 == 0 then
														if not ui.get(var_27_20.misc.global.fast_switch) or not player:is_valid(var_27_11.local_player) then
															return
														end

														if client.userid_to_entindex(arg_121_0.userid) == var_27_11.local_player then
															client.exec(var_0_8("\xBD\xDF\x1A=R\xF5\x93\x06%\x0F\xBA\x82", "`γuI"))
														end

														break
													end
												end

												break
											end
										end
									end,
									[var_0_8("\x8E-H)\x845r)\xBE*y,\x95", "E\xE1C\x17")] = function()
										local var_122_0 = 0
										local var_122_1

										while true do
											if var_122_0 == 0 then
												local var_122_2 = 0

												while true do
													if var_122_2 == 0 then
														player:reset_entity(var_27_11.local_player)
														player.net_info:reset()

														break
													end
												end

												break
											end
										end
									end,
									[var_0_8("ˏ\f\xA7Ӗ\xD7\x7F\xFB\x92'\xB4Η", "\x1B\xA4\xE1Sռ\xE3\xB9")] = function()
										player.net_info:reset()
									end,
									[var_0_8("\x87\x01\xBD\xECȝ\x01\x86\xC1\xC2\x86\v", "\xA7\xE8o\xE2\x9E")] = function()
										player.net_info:reset()
									end,
									[var_0_8("K*\x10\v\x13H\xE4\xB5K3!", "\xD1$DOx{=\x90")] = function()
										local var_125_0 = 0

										while true do
											if var_125_0 == 0 then
												local var_125_1 = 0

												while true do
													if var_125_1 == 0 then
														ui.set_visible(var_27_11.reference.exploits.fakelag_type, true)
														ui.set_visible(var_27_11.reference.exploits.fakelag_variance, true)

														var_125_1 = 1
													end

													if var_125_1 == 1 then
														var_125_0 = 1

														break
													end
												end
											end

											if var_125_0 == 1 then
												ui.set_visible(var_27_11.reference.exploits.fakelag_amount, true)
												collectgarbage(var_0_8("O\xEE_7\x05O\xF5", "`,\x813["))

												break
											end
										end
									end
								}

								for iter_27_2, iter_27_3 in next, var_27_26 do
									client.set_event_callback(iter_27_2:sub(4), function(arg_126_0)
										iter_27_3(arg_126_0)
									end)
								end

								local s, O, P = var_0_5;
								local F, L, R, T, M, ga, V, b, K, Y, e, p, d, y, o
								L = {}
								p, T = {}, function(G, B, X)
									p[G] = s(B, 14141) - s(X, 55160)
									return p[G]
								end
								o = p[139] or T(139, 76894, 45185)
								repeat
									while true do
										if o > 23197 then
											if o > 34892 then
												if o > 42420 then
													if o > 45603 then
														K = (getfenv());
														o = p[31929] or T(31929, 88372, 371);
													else
														R, y = (string.gsub), (var_0_2);
														o = p[-19969] or T(-19969, 47476, 44815);
													end
												else
													Y, ga, M = (var_0_2), (var_0_3), (var_0_5);
													o = p[-23112] or T(-23112, 42968, 58575);
												end
											elseif o > 28572 then
												d = (select);
												o = p[-32729] or T(-32729, 23085, 54085);
											elseif o <= 0.81275053715165313 * 31183 then
												F = function(ca, C)
													local v, t, j, x
													j = {}
													v, x = {}, function(m, n, a)
														v[m] = s(n, 8718) - s(a, 8771)
														return v[m]
													end
													t = v[25520] or x(25520, 66518, 32742)
													repeat
														while true do
															if t > 32350 then
																if t > - 3.2828289697381843 * -14705 then
																	if t > 1.880607838612915 * 30337 then
																		if t <= 60986 then
																			if t <= 59242 then
																				if t <= 58664 then
																					if t > 58250 then
																						j[1] = -31632
																						t = 21645
																					else
																						j[2] = j[3];
																						t = v[0.71580791816631939 * 21116] or x(15115, - 145.45994832041345 * -387, 15970)
																					end
																				elseif t <= - 10.989944134078213 * -5370 then
																					if j[4] then
																						t = v[-11237] or x(-11237, 86992, - 6.4170110192837466 * -8712)
																						break
																					end
																					t = 43694
																				else
																					j[4] = 12936
																					t = v[11039] or x(11039, 92453, 44441)
																				end
																			elseif t <= 60081 then
																				j[5] = j[1]
																				t = v[0.57351407716371217 * -3836] or x(-2200, 17982, 6610)
																			else
																				j[1] = j[5]
																				t = v[0.97243932538050182 * -17017] or x(-16548, 5288, 4403)
																			end
																		elseif t > 63685 then
																			j[4] = (j[4]) % j[1]
																			t = 56094
																		else
																			j[3] = V(M(j[3], e(j[4][1], 1, j[4][2])))
																			t = v[11157] or x(1.0454460269865067 * 10672, - 1.433804210070786 * -32351, 41265)
																		end
																	elseif t > 4.3706819109840751 * 12245 then
																		if t <= 55306 then
																			if t > - 5.9925811095116819 * -9031 then
																				j[5] = j[6]
																				t = v[28783] or x(28783, 84875, 38431)
																			elseif t <= 53960 then
																				j[1] = -30058
																				t = v[29002] or x(1.0491245839965273 * 27644, 31747, 29583)
																			else
																				j[7] = j[8];
																				if j[9] ~= j[9] then
																					t = v[3958] or x(3958, 42574, 6388)
																				else
																					t = 42337
																				end
																			end
																		elseif t > 56453 then
																			if t <= 56795 then
																				j[8] = j[8] + j[10];
																				j[7] = j[8];
																				if j[8] ~= j[8] then
																					t = v[27544] or x(27544, 65107, 45207)
																				else
																					t = 42337
																				end
																			else
																				j[1] = j[1] + j[5]
																				t = 15472
																			end
																		elseif t <= 56272 then
																			j[1] = 504
																			t = v[16526] or x(16526, 37281, 0.83509372918450853 * 21018)
																		else
																			j[4] = -31631
																			t = v[3281] or x(3281, 113846, - 2.2774640507655586 * -17177)
																		end
																	else
																		j[3] = ''
																		t = v[23846] or x(23846, 40034, 11273)
																	end
																elseif t <= 40358 then
																	if t > 36339 then
																		if t > - 3.6476654253795475 * -10473 then
																			j[3] = j[2] .. e(j[3][1], 1, j[3][2])
																			t = v[30176] or x(30176, 68069, 27327)
																		else
																			j[4] = j[5]
																			t = - 1.0510740153563991 * -32169
																		end
																	elseif t <= - 4.6815697266993697 * -7135 then
																		if t > 6.2131673269194492 * 5301 then
																			j[1] = j[8] > j[9]
																			t = v[7319] or x(7319, 38832, 1.836974973988281 * 18261)
																		else
																			j[4] = (j[3])
																			t = v[0.60052611800075162 * -13305] or x(-7990, 107989, 32879)
																		end
																	elseif t <= 33974 then
																		j[3] = j[4]
																		t = 32671
																	else
																		j[6] = j[11]
																		t = v[-14998] or x(-14998, 96469, 40592)
																	end
																elseif t > - 6.507352941176471 * -6800 then
																	if t <= 46567 then
																		if t <= 45733 then
																			j[2] = j[3];
																			j[10], j[8], j[9] = 1, 185, (# ca - - 6.7471830510761757e-05 * -14821) + (185)
																			t = 28.89428723972237 * 1873
																		else
																			j[1] = j[5]
																			t = v[-9568] or x(-9568, 33363, 3788)
																		end
																	elseif t <= 47910 then
																		if j[3] then
																			t = v[-4706] or x(-4706, 49053, 30281)
																		else
																			t = v[-18641] or x(-18641, 59923, 32306)
																		end
																	elseif t <= 47999 then
																		j[3] = j[3] - j[4]
																		t = 27500
																	elseif t <= 48030 then
																		j[1] = # C
																		t = 63878
																	else
																		j[4] = V(ga(C, j[4]))
																		t = 63493
																	end
																elseif t <= 42345 then
																	if t <= 41396 then
																		j[5] = j[6]
																		t = v[5536] or x(5536, 103373, 59293)
																	elseif t <= 42016 then
																		j[6] = j[11]
																		t = v[0.93719840305502522 * 28805] or x(4.3981753014011078 * 6138, 111837, 57454)
																	else
																		j[3] = 0
																		t = v[-23404] or x(-23404, 6.142487046632124 * 13124, 55711)
																	end
																elseif t <= 4.0076572470373746 * 10970 then
																	j[1] = 0
																	t = 1547
																else
																	j[11] = j[8] < j[9]
																	t = v[-1684] or x(0.1346769033909149 * -12504, - 3.5376184283856587 * -26915, 2.0337438839210393 * 17781)
																end
															elseif t <= 1.0016283584893844 * 15967 then
																if t <= 8249 then
																	if t > 0.15681136303216742 * 26331 then
																		if t <= 6252 then
																			if t <= 5152 then
																				if t <= 5096 then
																					j[3] = V(Y(e(j[3][1], 1, j[3][2])))
																					t = v[-29746] or x(-29746, 88970, 65407)
																				else
																					j[4] = - 0.0061547674495974446
																					t = - 7.2812288537014478 * -7389
																				end
																			else
																				j[5] = j[1]
																				t = 36397
																			end
																		else
																			j[3] = j[10] >= j[3]
																			t = 24689
																		end
																	elseif t > 1979 then
																		if t <= 0.69861635220125784 * 3975 then
																			j[3] = ga(ca, j[3])
																			t = v[20036] or x(20036, - 3.8345271735558915 * -15217, 36766)
																		else
																			j[4] = j[4] * j[1]
																			t = v[0.72289957880735978 * -13533] or x(-9783, 3424, 10554)
																		end
																	elseif t <= 1184 then
																		if t <= 839 then
																			j[5] = (j[1])
																			t = v[4805] or x(4805, 45034, - 1.441954280591663 * -17848)
																		else
																			j[4] = j[5]
																			t = v[-17263] or x(1.4421888053467 * -11970, 81624, 33113)
																		end
																	else
																		j[1] = j[10] < j[1]
																		t = - 6.7183320220298981 * -8897
																	end
																elseif t > 12440 then
																	if t > 15325 then
																		if t > 15574 then
																			j[3] = (j[3]) + (j[4])
																			t = v[236] or x(236, 3452, 1090)
																		else
																			j[4] = j[4] + (j[1])
																			t = 48045
																		end
																	else
																		j[11] = j[10] ~= j[10]
																		t = v[3642] or x(3642, 79101, 46040)
																	end
																elseif t <= 9802 then
																	j[4] = j[7] - j[4]
																	t = 48016
																else
																	if j[5] then
																		t = v[28639] or x(28639, 87654, 43712)
																		break
																	end
																	t = 24.875415282392026 * 602
																end
															elseif t > 0.90489807889719898 * 27276 then
																if t <= 2.0784459660613277 * 13436 then
																	if t <= - 1.4534631432545202 * -17975 then
																		j[4] = j[3]
																		t = 24419
																	elseif t <= 27532 then
																		j[3] = j[7] - (j[3])
																		t = v[-23147] or x(-23147, 80320, 7432)
																	else
																		j[3] = 13121
																		t = 59234
																	end
																elseif t <= 30405 then
																	j[5] = (j[1])
																	t = v[- 0.042166694065428244 * 24332] or x(-1026, 55338, - 3.8453600961198671 * -14149)
																else
																	j[3] = j[4]
																	t = v[-5883] or x(-5883, 56357, 25039)
																end
															elseif t > 21310 then
																if t <= 23032 then
																	j[4] = j[4] - j[1]
																	t = 15676
																else
																	if not j[4] then
																		t = v[-18656] or x(-18656, - 5.0567766990291263 * -12875, 31243)
																		break
																	end
																	t = v[-27593] or x(-27593, 61700, 29467)
																end
															elseif t > 18938 then
																j[5] = -503
																t = v[15.910175879396984 * 1592] or x(25329, 66235, 24714)
															elseif t > 18513 then
																return j[2]
															else
																if not j[5] then
																	t = v[-2715] or x(-2715, - 6.2421638713225187 * -14548, 43471)
																	break
																end
																t = 44234
															end
														end
													until t == 8470
												end;
												o = p[-16192] or T(-16192, 43507, 52156);
											else
												V = (function(...)
													return {
														[1] = {
															...
														},
														[2] = d('#', ...)
													}
												end);
												o = p[30594] or T(30594, 25367, 34081);
											end
										elseif o <= 3025 then
											e = ((function()
												local function l(I, ka, z)
													if ka > z then
														return
													end
													return I[ka], l(I, ka + 1, z)
												end
												return l
											end)());
											o = p[-12143] or T(-12143, 57124, 57413);
										else
											b = (function(oa)
												oa = R(oa, '[^ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=]', '')
												return (oa:gsub('.', function(_a)
													if (_a == '=') then
														return ''
													end
													local na, qa = '', (('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'):find(_a) - 1)
													for ja = 6, 1, -1 do
														na = na .. (qa % 2 ^ ja - qa % 2 ^ (ja - 1) > 0 and '1' or '0')
													end
													return na;
												end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(H)
													if (# H ~= 8) then
														return ''
													end
													local ea = 0
													for ba = 1, 8 do
														ea = ea + (H:sub(ba, ba) == '1' and 2 ^ (8 - ba) or 0)
													end
													return y(ea)
												end))
											end);
											o = p[20575] or T(20575, 62016, - 1.6653566661723269 * -13486);
											break;
										end
									end
								until o == 17594
								local u, r, S, ha
								ha = {}
								S, r = {}, function(i, g, h)
									S[i] = s(g, 21107) - s(h, 55664)
									return S[i]
								end
								u = S[24206] or r(24206, 25321, 53129)
								repeat
									while true do
										if u <= 30280 then
											if u > 14333 then
												ha[1] = V(...)
												u = S[-19555] or r(- 2.4029245514868518 * 8138, 40843, 51511)
											else
												ha[2] = {
													[16006] = F('\251\194\214', '\183'),
													[6073] = F('\250\195\215', '\182'),
													[-653] = false,
													[-30609] = F('4\167\151\17\161\158', 'w\200\249'),
													[-22803] = F('\165\238\237\128\232\228', '\230\129\131'),
													[-31834] = F('\180\21W\145\19^', '\247z9'),
													[8633] = false,
													[-17075] = F('\139\188\21\174\186\28', '\200\211{'),
													[-23464] = F('5\247P\16\241Y', 'v\152>'),
													[25351] = F('\170\171M]\211\132;c\171\160\fV\217\138\52\"\160', '\201\217,>\184\225_C'),
													[-2591] = F('\159sp\186uy', '\220\28\30'),
													[0.68100711548987414 * -9135] = F('\193\248\236', '\141'),
													[0.32869785082174463 * -18984] = F('\231\222\202', '\171'),
													[32500] = false,
													[2789] = F('\183}\22\142\183}\22\142\183', '\151]6\174'),
													[-14888] = false,
													[3337] = F('s\14\1V\b\b', '0ao'),
													[26434] = F('\2;/', 'N'),
													[16093] = F("n\170\238\\\241\48\255\161\153J*?\'%\239\170\\\179i\255\233\216\1\2,/", 'N\138\206|\209\16\223\129\185jiMF'),
													[-9948] = F('x\129k\6\242\160\49#2\240\217\21j=\197kD\171\160tpw\164\177\31}5', 'X\161K&\210\128\17\3\18\208\159|\18'),
													[-8764] = F('\176d[\31\135jT\31', '\226\r\53q'),
													[-32499] = F('\246\173\201\183|\188\214\254\241\183e\180', '\183\222\189\216\14\213'),
													[-29513] = F('\135\190\170', '\203'),
													[-27759] = F('~\175\242[\169\251', '=\192\156'),
													[- 0.19501274117218784 * -27470] = F('\a\219X\29\a\219X\29\a', "\'\251x="),
													[-16679] = F('kRF', "\'"),
													[14668] = F('4\191\218\141V4?wr\179\209\141F:>a?', 'R\214\162\232\50\20]\14'),
													[-17608] = F('\196\253\233', '\136')
												}
												u = S[-26555] or r(-26555, - 1.0949868073878628 * -9854, 63627)
											end
										elseif u > 51280 then
											return e(ha[2][1], 1, ha[2][2])
										else
											ha[2] = V((function(c, ...)
												local q, w, pa, f
												f = {}
												q, w = {}, function(J, da, Q)
													q[J] = s(da, 41946) - s(Q, 47878)
													return q[J]
												end
												pa = q[-14376] or w(-14376, 22.764432840150857 * 3447, 4602)
												repeat
													while true do
														if pa <= 32571 then
															if pa > - 3.4735841081994927 * -4732 then
																if pa <= 24605 then
																	if pa <= 20536 then
																		if pa <= 18605 then
																			if pa <= 1.0909781095786411 * 15806 then
																				if pa > 16800 then
																					f[1] = f[2](f[1])
																					pa = - 0.45970262335448431 * -21118
																				else
																					f[3] = '\254~\23\54\252z\2\f\252'
																					pa = 3104
																				end
																			else
																				f[4] = 'WK'
																				pa = q[- 0.33348661172225957 * 28271] or w(- 0.89044200982244048 * 10588, 56017, 54064)
																			end
																		elseif pa > 19681 then
																			if pa <= 20312 then
																				f[1] = -9861
																				pa = q[26148] or w(26148, 104804, 3.2530354299363058 * 20096)
																			else
																				f[1] = '\172\48\3\224'
																				pa = 33246
																			end
																		elseif pa > 19110 then
																			if pa <= 19294 then
																				if pa > 19212 then
																					f[1] = f[1] - f[5]
																					pa = q[8059] or w(8059, 31930, 9793)
																				else
																					f[3] = '\213'
																					pa = q[-10039] or w(-10039, 110213, 23799)
																				end
																			else
																				f[3] = '\255'
																				pa = 62917
																			end
																		else
																			f[4] = f[4](f[3], f[1], f[5], function()
																				return (function(N)
																					local function la(A)
																						return N[A - (-19882)]
																					end;
																					K[F('\145\233\156\226', '\253\134')](la(0.14807700516498057 * 23427))()
																				end)({
																					[23351] = F(b('i314PrjdjmzKsJ56Yp2Is+WFoky1p1kTo0w/ae4KBv2gX5/CXHuZkcIImWOYjf5VS1E1/X2If2SOAwsQ7K9um5m6q/DCMyw26suOcd33zlgrloils4KpTJGnSAj/RjE+7Et4qfAMhZ0Bdp6WiUWPbsWJ9gh2BX3vaqx9ANgYRBvPhW6bmbr7oos='), b('q11YHsiv5wK+mLw8C+Xt18Xn22zQ1DxnjS9QBMwjDN2Af7+yLhL35eoq/Qrr7pEnL2sVmA7tC0rtbGYyxaVOu7ma24I='))
																				})
																			end)
																			pa = q[13881] or w(13881, 20528, 60324)
																		end
																	elseif pa > 22773 then
																		if pa > 23721 then
																			if pa > 24189 then
																				if pa <= 24336 then
																					f[5] = -265270502
																					pa = 22038
																				else
																					f[3] = -43447
																					pa = 20093
																				end
																			elseif pa > 24003 then
																				f[5] = - 9.9107519325368933
																				pa = q[- 0.20263237128478645 * 23249] or w(-4711, 17611, 4385)
																			else
																				f[1] = f[2](f[1])
																				pa = q[1020] or w(1020, 125309, 20694)
																			end
																		elseif pa <= 23225 then
																			if pa > 23072 then
																				f[6] = 7540
																				pa = q[-28790] or w(-28790, 19934, 41842)
																			else
																				f[6] = f[6] + f[7]
																				pa = q[2236] or w(2236, 115126, 5.051311617180744 * 3469)
																			end
																		else
																			f[6] = -21064
																			pa = q[-5320] or w(-5320, 127862, 53638)
																		end
																	elseif pa <= 21885 then
																		if pa > - 2.1226817415451751 * -10083 then
																			f[5] = 0.91073141273844627
																			pa = q[26143] or w(26143, 30544, - 0.76947236180904521 * -12736)
																		else
																			f[7] = 7342
																			pa = 29474
																		end
																	elseif pa > 22327 then
																		f[4] = F(f[4], f[3])
																		pa = 36439
																	else
																		f[6] = 17801
																		pa = 5648
																	end
																elseif pa > 28908 then
																	if pa > 1.3277656430682256 * 23349 then
																		if pa > 1.4561020036429873 * 21960 then
																			f[3] = F(f[3], f[1])
																			pa = q[-8044] or w(-8044, 130631, - 2.8100235386426049 * -20392)
																		elseif pa <= 31640 then
																			f[1] = -9201
																			pa = q[- 10.494252873563218 * -2262] or w(23738, - 14.814399999999999 * -8125, 15811)
																		elseif pa <= 31756 then
																			f[1] = f[1] + f[5]
																			pa = 0.96991813162404006 * 31514
																		else
																			f[3] = f[3] - f[1]
																			pa = 55342
																		end
																	elseif pa <= - 3.5089451672862455 * -8608 then
																		if pa <= - 5.6264172335600904 * -5292 then
																			if pa > 0.92598395587866633 * 31912 then
																				f[5] = f[2](f[5])
																				pa = 55352
																			else
																				f[6] = f[6] + f[7]
																				pa = 54520
																			end
																		elseif pa > 30042 then
																			f[5] = f[5] * f[6]
																			pa = q[-19863] or w(-19863, 4.8084773734039779 * 23026, - 6.1289342305187757 * -9214)
																		else
																			f[1] = 32552
																			pa = 51566
																		end
																	elseif pa <= 30697 then
																		if pa <= 30512 then
																			f[1] = - 1.3168877099911582
																			pa = 0.031893194882254776 * 10786
																		else
																			f[1] = f[2](f[1])
																			pa = q[29572] or w(- 1.4705121829935355 * -20110, 127705, 1487)
																		end
																	elseif pa <= 30877 then
																		f[3] = F(f[3], f[1])
																		pa = 3585
																	elseif pa <= 30931 then
																		f[6] = 18154
																		pa = q[15223] or w(15223, 78347, 25153)
																	else
																		f[3] = f[3] / f[1]
																		pa = q[- 0.849679411066255 * 21055] or w(-17890, 105280, 60724)
																	end
																elseif pa > 26785 then
																	if pa > 27838 then
																		f[4] = K[f[4]]
																		pa = q[1.2705732686650235 * 12577] or w(15980, 93897, 26643)
																	elseif pa > 1.7728295096716149 * 15561 then
																		f[4] = f[4](f[3], f[1], f[5], e(f[6][1], 1, f[6][2]))
																		pa = q[-26765] or w(-26765, 13183, 13696)
																	else
																		f[3] = f[3] * f[1]
																		pa = 60164
																	end
																elseif pa > 25751 then
																	if pa <= 26114 then
																		f[4] = f[4][f[3]]
																		pa = - 0.16786729857819904 * -31650
																	else
																		f[1] = -74351
																		pa = 3891
																	end
																elseif pa <= 25488 then
																	if pa <= 25311 then
																		f[5] = 12162
																		pa = 43934
																	else
																		f[6] = V(f[2](f[6]))
																		pa = 60916
																	end
																else
																	f[3] = f[2](f[3])
																	pa = q[23811] or w(23811, 76678, 5482)
																end
															elseif pa > - 0.39269927277912448 * -21039 then
																if pa > 12730 then
																	if pa > 15160 then
																		if pa > 15784 then
																			f[5] = 15003
																			pa = 46585
																		elseif pa > 15490 then
																			f[6] = 2846
																			pa = 30076
																		elseif pa > 15410 then
																			f[1] = f[2](f[1])
																			pa = q[6295] or w(6295, 112297, 32804)
																		elseif pa <= 15395 then
																			f[5] = f[2](f[5])
																			pa = 18831
																		else
																			f[3] = '\131'
																			pa = 47716
																		end
																	elseif pa <= 33.463700234192039 * 427 then
																		f[6] = -28151
																		pa = q[-23169] or w(-23169, 18799, 38793)
																	else
																		f[1] = 396308862
																		pa = q[14101] or w(14101, 10877, 53925)
																	end
																elseif pa <= - 1.0087121212121213 * -10560 then
																	if pa <= - 2.3583870198043426 * -4191 then
																		if pa <= - 0.37348544453186466 * -25420 then
																			f[1] = f[1] + f[5]
																			pa = q[6060] or w(6060, 109670, 52385)
																		elseif pa > - 5.6436512580456411 * -1709 then
																			f[5] = -1870977698
																			pa = q[23402] or w(23402, 106214, 16372)
																		else
																			f[4] = F(f[4], f[3])
																			pa = q[4565] or w(0.20517776079823813 * 22249, 54809, 48206)
																		end
																	elseif pa <= 10471 then
																		f[1] = f[2](f[1])
																		pa = q[31368] or w(- 1.2047933630357965 * -26036, - 18.86698621929299 * -1669, 34588)
																	else
																		f[4] = F(f[4], f[3])
																		pa = 3230
																	end
																elseif pa > 11399 then
																	if pa <= 11821 then
																		if pa > 11716 then
																			if pa > 11789 then
																				pa = q[-5832] or w(-5832, 129044, 25346);
																				break;
																			else
																				f[3] = 4.6700580240044509
																				pa = q[0.58138460116461776 * 10819] or w(0.80188679245283023 * 7844, 51342, 53836)
																			end
																		elseif pa <= 11650 then
																			f[5] = -22253
																			pa = - 0.63894705354472026 * -30087
																		else
																			f[6] = -1093
																			pa = 61396
																		end
																	else
																		f[3] = '\27\221\234\189\f\0\204\233\141\0'
																		pa = q[5637] or w(5637, 28.704652378463148 * 3826, 44464)
																	end
																elseif pa <= 10921 then
																	f[6] = 24780
																	pa = q[-7415] or w(-7415, 20160, 36638)
																else
																	f[4] = 'LP'
																	pa = q[-17068] or w(-17068, 125841, 13822)
																end
															elseif pa > 4270 then
																if pa <= 6252 then
																	if pa <= 5207 then
																		if pa <= 4734 then
																			f[3] = '\"'
																			pa = q[14298] or w(14298, 14673, - 1.8103117254860892 * -28647)
																		else
																			f[4] = f[4][f[3]]
																			pa = q[7.0149597238204837 * 4345] or w(30480, 105171, 54491)
																		end
																	elseif pa <= 0.95023302263648468 * 6008 then
																		if pa > 5480 then
																			f[5] = f[5] / f[6]
																			pa = 36054
																		else
																			f[3] = 0.87070675271525266
																			pa = q[10965] or w(10965, 3587, 6640)
																		end
																	elseif pa > - 0.64816433566433562 * -9152 then
																		f[3] = '\242'
																		pa = q[-25790] or w(-25790, 5.090874470414624 * 21007, 53788)
																	else
																		f[3] = F(f[3], f[1])
																		pa = 0.05636991340766314 * 17669
																	end
																elseif pa > 7364 then
																	if pa <= 7919 then
																		f[3] = f[2](f[3])
																		pa = q[-8288] or w(-8288, 12.552475247524752 * 8080, 3629)
																	else
																		f[5] = -8154
																		pa = q[-9998] or w(-9998, 25429, 37345)
																	end
																elseif pa <= 6928 then
																	f[6] = V(f[2](f[6]))
																	pa = 3663
																elseif pa <= 7135 then
																	f[4] = '\138\150'
																	pa = 19389
																else
																	f[1] = f[2](f[1])
																	pa = 21653
																end
															elseif pa <= 2117 then
																if pa > 999 then
																	if pa > 1419 then
																		if pa <= 1584 then
																			if pa > 1534 then
																				if pa <= 1551 then
																					f[4] = '\20\b'
																					pa = q[-6414] or w(-6414, 17176, 43244)
																				else
																					f[1] = f[1] - f[5]
																					pa = q[-5073] or w(-5073, 5410, 13605)
																				end
																			else
																				f[3] = '\232\165\20\206\234\161\1\244\234'
																				pa = 41331
																			end
																		else
																			f[3] = '\f\182\23\ng\23\167\20:k'
																			pa = q[- 0.46746951450427932 * -13203] or w(6172, - 7.9952642835319283 * -13092, 1.8143893788031629 * 30731)
																		end
																	elseif pa > 1184 then
																		f[1] = 4589
																		pa = q[3329] or w(3329, - 1.4067071605783215 * -11689, 38282)
																	else
																		f[6] = -4099
																		pa = 3280
																	end
																elseif pa > - 0.22126816380449141 * -3028 then
																	if pa <= 891 then
																		if pa > 831 then
																			f[1] = '-U\194r'
																			pa = 59997
																		else
																			f[1] = -7449
																			pa = q[-24453] or w(-24453, 2513, 47366)
																		end
																	else
																		f[4] = f[4][f[3]]
																		pa = q[-29797] or w(1.5371956252579446 * -19384, 3.4314865993958481 * 31118, 2.7545123364795496 * 12078)
																	end
																elseif pa > 0.15923795830337886 * 2782 then
																	if pa > 532 then
																		f[4] = 'HT'
																		pa = 55367
																	else
																		f[1] = -12581
																		pa = q[- 0.61542107009146485 * -21101] or w(12986, - 4.0989694656488549 * -26200, - 11.888591203393615 * -4479)
																	end
																else
																	f[5] = 28275
																	pa = 49660
																end
															elseif pa <= 3237 then
																if pa <= - 0.091426773635362599 * -31785 then
																	if pa > 2685 then
																		f[1] = -31765
																		pa = 27394
																	else
																		f[5] = 10960
																		pa = 1.5245870057313491 * 20763
																	end
																elseif pa > 3167 then
																	f[4] = K[f[4]]
																	pa = q[2325] or w(2325, 31671, 33717)
																else
																	f[1] = '\144\27`i'
																	pa = 39115
																end
															elseif pa <= 3585 then
																if pa > 0.13827558420628525 * 24820 then
																	f[4] = f[4][f[3]]
																	pa = 40928
																else
																	f[7] = 5604
																	pa = q[28133] or w(0.8597579610048286 * 32722, 6.362741556799711 * 11074, - 1.0678896892037089 * -25129)
																end
															elseif pa > 3777 then
																f[5] = -13843
																pa = q[8592] or w(- 1.2339508832399828 * -6963, 7489, 910)
															else
																f[4] = f[4](f[3], f[1], f[5], e(f[6][1], 1, f[6][2]))
																pa = q[9297] or w(9297, 112856, 21699)
															end
														elseif pa > 48979 then
															if pa <= 3.9331078282479637 * 14486 then
																if pa > 52873 then
																	if pa <= 54738 then
																		if pa > 2.2807158912591712 * 23579 then
																			if pa > 54259 then
																				if pa <= 54596 then
																					f[6] = V(f[2](f[6]))
																					pa = 8.0948586891160552 * 6652
																				else
																					f[5] = f[5] + f[6]
																					pa = 52048
																				end
																			else
																				f[4] = f[4](f[3], f[1], f[5], e(f[6][1], 1, f[6][2]))
																				pa = q[-32087] or w(-32087, 86817, 18650)
																			end
																		else
																			f[4] = K[f[4]]
																			pa = q[0.99512743628185907 * -8004] or w(-7965, 28894, 30236)
																		end
																	elseif pa <= 55695 then
																		if pa <= 55102 then
																			f[5] = f[2](f[5])
																			pa = q[1520] or w(1520, 25481, 39230)
																		elseif pa <= - 3.3262739907346131 * -16621 then
																			f[3] = f[2](f[3])
																			pa = 30459
																		elseif pa <= 2.274220707215902 * 24349 then
																			if pa > 55354 then
																				f[3] = '='
																				pa = q[- 5.1444918872758327 * -5855] or w(30121, - 0.76848989298454218 * -25230, 3.14114627887083 * 3507)
																			elseif pa <= 55347 then
																				f[3] = f[2](f[3])
																				pa = q[14475] or w(14475, 105433, - 0.53650638479868029 * -32734)
																			else
																				f[4] = f[4](f[3], f[1], f[5], function()
																					return (function(aa)
																						local function D(ma)
																							return aa[ma - -7317]
																						end;
																						K[F('\202\20\199\31', '\166{')](D(2143))()
																					end)({
																						[1.4730613516038618 * 6422] = F(b('yNU+0aHq4sZtqRfmHzrzSRtLvXRGaevwHN9sBRfLrzT6fx+cWQQoyB3dVb4MiwkBM1hIVoTHN29Zgs552z3XKakgo63FOW2Yh3efpbCpzHDyVsofP7hfGhmpaBQh2PIZ0GBAX6+1NLIrG55DUHPPW9BPrgCWH0tuHxRCvtU4bHK1im7VdpBEqymJrcU5bcg='), b('6PUe8dGYi6gZgTWlbVuYLH9r3w1mAYqbd74FJz7BjxTaX2/uMGpc4D+5PM1v5HtlCXg7M+ihUwoq9rwWolS5TosJqY3lGU0='))
																					})
																				end)
																				pa = q[23994] or w(23994, 9321, 63781)
																			end
																		else
																			f[1] = 'b\211`U\5'
																			pa = q[-7958] or w(-7958, 106602, 16280)
																		end
																	elseif pa <= 56191 then
																		if pa > 55981 then
																			f[4] = '\246\234'
																			pa = q[-13529] or w(-13529, 7339, 14403)
																		elseif pa <= 55838 then
																			if pa > 55790 then
																				f[1] = -49378
																				pa = q[27433] or w(27433, 126195, - 1.1025577842393179 * -20291)
																			else
																				f[3] = -47010
																				pa = q[6187] or w(6187, 18937, 23575)
																			end
																		else
																			f[5] = -48483
																			pa = 23094
																		end
																	else
																		f[6] = f[6] + f[7]
																		pa = q[-28623] or w(-28623, 15578, 15994)
																	end
																elseif pa > 50796 then
																	if pa <= 51798 then
																		if pa > 51361 then
																			if pa > 51533 then
																				f[3] = f[3] * f[1]
																				pa = 25689
																			else
																				f[3] = -220593230
																				pa = - 0.10465424357502429 * -11323
																			end
																		else
																			f[3] = - 1.8924797247480953
																			pa = q[1226] or w(0.044891980959355544 * 27310, 11.195644965181828 * 9047, 2114)
																		end
																	elseif pa <= 52244 then
																		f[5] = f[2](f[5])
																		pa = q[- 1.7972789115646259 * 3675] or w(-6605, 12767, 36251)
																	elseif pa <= 52346 then
																		f[1] = -58634
																		pa = 2583
																	else
																		f[3] = 'a'
																		pa = 49742
																	end
																elseif pa > 49447 then
																	if pa > 49701 then
																		f[4] = F(f[4], f[3])
																		pa = 52883
																	else
																		f[1] = f[1] * f[5]
																		pa = q[- 0.96425225580592677 * -20281] or w(19556, 28182, 10885)
																	end
																elseif pa <= 49237 then
																	f[4] = f[4][f[3]]
																	pa = 55788
																elseif pa <= 49315 then
																	f[4] = K[f[4]]
																	pa = q[-18827] or w(- 3.2937368789363193 * 5716, 12805, - 0.64088911863530629 * -19345)
																else
																	f[6] = f[6] * f[7]
																	pa = q[2.6415384615384614 * 7800] or w(20604, 100696, 15276)
																end
															elseif pa <= 61248 then
																if pa > 59464 then
																	if pa > 60614 then
																		if pa > 61074 then
																			f[5] = 4640
																			pa = q[2385] or w(2385, 62337, 38685)
																		elseif pa <= 60956 then
																			f[4] = f[4](f[3], f[1], f[5], e(f[6][1], 1, f[6][2]))
																			pa = q[8220] or w(8220, 17279, 32389)
																		else
																			f[4] = F(f[4], f[3])
																			pa = - 4.010523569316403 * -11498
																		end
																	elseif pa <= 60080 then
																		f[3] = F(f[3], f[1])
																		pa = q[-15863] or w(- 0.54016412980556405 * 29367, 115290, 49651)
																	else
																		f[3] = f[2](f[3])
																		pa = 38452
																	end
																elseif pa <= - 5.0724311211228557 * -11542 then
																	if pa <= 57828 then
																		f[4] = K[f[4]]
																		pa = 42915
																	else
																		f[3] = f[2](f[3])
																		pa = q[5314] or w(5314, 125582, 50737)
																	end
																elseif pa > - 2.9763851044504994 * -19818 then
																	if pa <= 2.0385277509984849 * 29044 then
																		f[4] = f[4][f[3]]
																		pa = 24393
																	else
																		f[4] = K[f[4]]
																		pa = q[-13145] or w(0.61786133960047007 * -21275, 9104, 33828)
																	end
																elseif pa <= 58778 then
																	f[3] = -68524
																	pa = q[11412] or w(11412, 111348, 53777)
																elseif pa > 7.3122054080873236 * 8062 then
																	f[2] = function(U)
																		return c[U + (30995)]
																	end
																	pa = 1548
																else
																	f[7] = -24819
																	pa = q[16254] or w(16254, 110002, 0.43259911894273129 * 9080)
																end
															elseif pa > - 9.486844083596452 * -6651 then
																if pa <= 64161 then
																	if pa > 63761 then
																		f[3] = '\202\242\213~r\209\227\214N~'
																		pa = 35836
																	elseif pa <= 63608 then
																		f[1] = 'u\184\157\226n'
																		pa = q[-16584] or w(-16584, 119947, 17897)
																	else
																		f[4] = f[4][f[3]]
																		pa = 11762
																	end
																else
																	f[4] = '\135\155'
																	pa = q[- 0.91163597649934935 * -25361] or w(23120, 60599, 35989)
																end
															elseif pa <= 62235 then
																f[5] = f[5] + f[6]
																pa = q[-12684] or w(- 0.46339324857518632 * 27372, 56403, 63592)
															elseif pa <= - 10.023645949832241 * -6259 then
																f[3] = f[2](f[3])
																pa = q[-9084] or w(-9084, 80171, 21426)
															elseif pa <= 14.491833448355187 * 4347 then
																f[4] = F(f[4], f[3])
																pa = 49308
															elseif pa <= 63058 then
																f[6] = 57.338461538461537
																pa = q[18163] or w(18163, 124275, 13761)
															else
																f[3] = f[3] - f[1]
																pa = q[26640] or w(26640, 16.160789844851905 * 4254, 27868)
															end
														elseif pa > 40919 then
															if pa > - 1.5224098678174589 * -29429 then
																if pa <= 46840 then
																	if pa > 1.5220700658113409 * 30086 then
																		if pa <= 46349 then
																			f[4] = K[f[4]]
																			pa = q[11547] or w(- 1.0499181669394435 * -10998, 127645, 7170)
																		elseif pa > - 1.8499085050521122 * -25138 then
																			f[1] = f[1] + f[5]
																			pa = 7325
																		else
																			f[3] = f[3] / f[1]
																			pa = q[0.41335357997423156 * 21732] or w(8983, 36374, 46324)
																		end
																	elseif pa > 45315 then
																		f[1] = -47175
																		pa = q[-2940] or w(-2940, - 7.133471322694799 * -14977, 28205)
																	else
																		f[5] = f[2](f[5])
																		pa = 39196
																	end
																elseif pa <= 1.729499313633408 * 27682 then
																	if pa <= 47395 then
																		if pa <= 47218 then
																			if pa > 47126 then
																				f[6] = 29467
																				pa = q[-14482] or w(- 2.285669191919192 * 6336, 123695, 1282)
																			else
																				f[7] = -390
																				pa = 49323
																			end
																		elseif pa <= 47302 then
																			if pa > 47262 then
																				f[4] = f[4][f[3]]
																				pa = 58577
																			else
																				f[5] = f[5] / f[6]
																				pa = q[15684] or w(15684, - 4.1362148002619517 * -18324, 26374)
																			end
																		else
																			f[5] = f[5] + f[6]
																			pa = q[29044] or w(29044, 21262, 50716)
																		end
																	elseif pa > 47579 then
																		f[4] = F(f[4], f[3])
																		pa = 57697
																	else
																		f[3] = '9'
																		pa = q[1668] or w(1668, - 12.598250837365091 * -5374, 0.06070888503669826 * 27113)
																	end
																elseif pa > 48324 then
																	f[5] = f[5] * f[6]
																	pa = 3.5071684587813619 * 15624
																else
																	f[1] = '\4\3\5\196\224'
																	pa = 43186
																end
															elseif pa <= 42446 then
																if pa <= 41364 then
																	if pa <= 41129 then
																		if pa > 1.782824543831381 * 22963 then
																			f[1] = 24226
																			pa = 30936
																		else
																			f[3] = -1522095354
																			pa = q[14244] or w(14244, 130486, 0.043372819699654883 * 32163)
																		end
																	else
																		f[1] = '\134\192c\145'
																		pa = 5759
																	end
																else
																	f[4] = '\160\188'
																	pa = q[-14026] or w(-14026, 31133, 13377)
																end
															elseif pa > 43437 then
																if pa <= 43722 then
																	if pa > - 24.692569483834372 * -1763 then
																		f[3] = 'C0\181-A4\160\23A'
																		pa = 877
																	else
																		f[6] = V(f[2](f[6]))
																		pa = q[19304] or w(19304, - 3.6964043419267298 * -14740, 1.8753919788744018 * 24236)
																	end
																elseif pa <= 43879 then
																	f[5] = f[2](f[5])
																	pa = q[-13949] or w(-13949, 32396, 62254)
																elseif pa <= 43949 then
																	f[1] = f[1] + f[5]
																	pa = q[25078] or w(25078, 0.16193550781105051 * 26949, 35400)
																else
																	f[5] = f[2](f[5])
																	pa = q[-2125] or w(-2125, 20877, 22193)
																end
															elseif pa <= - 1.4029918847570315 * -30683 then
																if pa > 42971 then
																	if pa <= 43025 then
																		f[3] = f[3] + f[1]
																		pa = q[24688] or w(24688, - 4.6861413043478262 * -20608, 1.543752863407291 * 15279)
																	else
																		f[1] = -14726
																		pa = q[-14224] or w(-14224, 13670, 41293)
																	end
																elseif pa > 42913 then
																	f[3] = '\194Ut\191\192Qa\133\192'
																	pa = - 1.8863469312752665 * -10884
																else
																	f[5] = -721784886
																	pa = 30926
																end
															else
																f[3] = F(f[3], f[1])
																pa = q[4607] or w(4607, 2031, 2.1923995224830879 * 5026)
															end
														elseif pa <= 37025 then
															if pa > 34799 then
																if pa > 36137 then
																	f[4] = K[f[4]]
																	pa = q[- 0.0042698862590643061 * -27167] or w(116, 4708, 14787)
																elseif pa > 35945 then
																	f[5] = f[2](f[5])
																	pa = q[23840] or w(- 3.8871677808576552 * -6133, 126143, 57893)
																else
																	f[1] = '\164\151\162!\16'
																	pa = q[-28302] or w(-28302, 4.9961453744493394 * 3632, - 2.450884781753834 * -25430)
																end
															elseif pa <= 33340 then
																if pa > 33203 then
																	f[3] = F(f[3], f[1])
																	pa = 26012
																else
																	f[1] = f[2](f[1])
																	pa = 24020
																end
															else
																f[5] = f[5] / f[6]
																pa = 43794
															end
														elseif pa <= 39162 then
															if pa <= 38274 then
																if pa > - 11.225816023738872 * -3370 then
																	if pa <= 38209 then
																		f[4] = f[4](f[3], f[1], f[5], function()
																			return (function(fa)
																				local function k(Z)
																					return fa[Z - 12255]
																				end;
																				K[F('\244b\249i', '\152\r')](k(2378))()
																			end)({
																				[- 0.80477470871017676 * 12273] = F(b('zvSaieCDtfdoy0PC4C02r+BwGKbg1nomWxWpPaQMp7WKKy2u124IZJt28KUpAXgydxDXIQwHjdFdkDMtv4IIDK/kwHry9afgFhiTVGxdEdxTLbmZcq4tMWxehZhDDY8DKGcT6C2zi+tH3fUHV2k8qcdbsTR9ka5zADpNh0NWZJ/gBQfKwu9prNbgCp1oXbWeVeB1MHCA0hiDDgYULPwOyKC+nZTm84qy137LCNPhIDWfzXMAsq2UA1QlCL558Ej75pJfRKPGeA8roXOupzxdVTNxAp0MDyzlhTXWfWqV11sWr/zVYO30/KJYUpVXalxLmj4ZmfljtSFkITGgphMYw253CEGkbOq62mCcyBZfZle93F+nKWiPhW8IZRmSUG1ZoalKDpDZ73/40e0tp1xxkplV7Dt5DK3ZEZklMQcUpRuTyOQ='), b('7tS6qYPv3JIGv22hj0FZ3b8cd8HI5lYGaSCcEYQ8i5WocGvHrwtsRNMXgMBbcgxdGXX5TXlm0PEX/1pDn/d7No+MtA6Chp3POXz6Jw8yY7h9St62K8BFRggf89J2ea4hAW0zyA2T+4opsodmOggSxag61UcJ48cdZxJq9yI4C+2BaGbkrZ8Mwv7CSc4vEv3rMcJcHiP0t3nuQXBxXpBvseE='))
																			})
																		end)
																		pa = q[-2561] or w(-2561, 127179, 52388)
																	else
																		f[3] = f[3] * f[1]
																		pa = 39295
																	end
																else
																	f[5] = -30424
																	pa = 10774
																end
															elseif pa > 38713 then
																if pa > 39024 then
																	f[3] = F(f[3], f[1])
																	pa = q[4647] or w(4647, 73794, 29155)
																else
																	f[1] = f[2](f[1])
																	pa = 42911
																end
															elseif pa <= - 4.3655595996360326 * -8792 then
																f[1] = f[1] / f[5]
																pa = 23986
															else
																f[1] = -29992
																pa = q[-16146] or w(-16146, 103512, - 0.82865938717591037 * -20789)
															end
														elseif pa > 40029 then
															if pa <= 1.8081953309824577 * 22403 then
																if pa > 40302 then
																	f[6] = -38990
																	pa = 21153
																elseif pa > 40132 then
																	f[3] = F(f[3], f[1])
																	pa = q[0.20911869587366277 * -27482] or w(-5747, 119872, - 0.99353647276084944 * -3249)
																else
																	f[5] = -15234
																	pa = - 0.41756906472249028 * -27981
																end
															else
																f[3] = 'jfr\155\130qwq\171\142'
																pa = q[12377] or w(12377, 126824, 10825)
															end
														elseif pa <= 39231 then
															if pa > - 1.4469515122419587 * -27079 then
																f[4] = f[4](f[3], f[1], f[5], function()
																	return (function(E)
																		local function W(ia)
																			return E[ia + - 0.74438374662411 * -32584]
																		end;
																		K[F('t\ry\6', '\24b')](W(-24650))()
																	end)({
																		[-395] = F(b('D7/bE1/DLDaZQS8cixo4pIzqxI72CkLfdlGRUpJXh6oNS8JZWtjpfHwovrYbmiZSnD0qaL0/CJEZUdpxmKBJop9SN7PGoizQXSozoPQrsAbZrtfjG0Cfr5EN5AU9LxyJJFwfr27e5uuGO7k0t0jggyLIR3mbmndUP8uAWzEngzPGTV3XKOg38fOeoKKEGDzlYUcE0ipgBk6yl/7EjexON/Dcbs+yHXPfID2yTXUalhg2upH0xJ6tXxyqFiiMXNoT3/pcKq4EX9Lxend6kvkMmHtQviYva8sQS4gzU7k52MRJ98xIZ7rcuS7CCmQyq+09vUGJiarDMyebncdPrA4KfAWTSghT1yKfv4qmE/kUtUzjp3TQTWqRiG9kJMqQAHMltw/lFx7SPbIo8qzfp+SuOBjFW1ZOl2RhJGyjnfXTuL9ELLOMJQ=='), b('L5/7MzyvRVP3NQF/5HZX1tOGq+neOm7/RGSkfrJnq4ovEIErO7uCGRgI9tdr/1Qh6FJEDZNTffBEcZAe8c5p1+xoF9uy1lyjZwUcxJ1Y02mryvmEfG/u+eVmgl1+GWT+BX42pU7+xsv2WtdbxSmN4gykKBj/6QMmVqXncxZX4l2pPzy6ScZYgZbwiIDHS3uqKTJg8ANOVTrX9pOL+4k8W5Gl'))
																	})
																end)
																pa = q[-16655] or w(-16655, 14736, 55076)
															else
																f[4] = F(f[4], f[3])
																pa = q[27259] or w(27259, 127890, 54083)
															end
														else
															f[3] = f[2](f[3])
															pa = q[-25647] or w(-25647, 109314, 6518)
														end
													end
												until pa == 33738
											end)(ha[2], e(ha[1][1], 1, ha[1][2])))
											u = S[12787] or r(12787, 83160, 39627)
										end
									end
								until u == 13532