class NumberConverter {

   /**
   * Converts a decimal integer into its hex / unicode / 16-base counterpart
   * @param num
   * @returns {Integer}
   */
   DecToHex(num, hexPrefix := true) => Format((hexPrefix ? "0x" : "") "{:x}", num)

   HexToDec(num) => Format("{:u}", num)

}