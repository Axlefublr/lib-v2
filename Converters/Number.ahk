; No dependencies

class NumberConverter {

	/**
	* Converts a decimal integer into its hex / unicode / 16-base counterpart
	* @param num
	* @returns {Integer}
	*/
	static DecToHex(num, hexPrefix := true) => Format((hexPrefix ? "0x" : "") "{:x}", num)

	static HexToDec(num) => Format("{:u}", num)

}