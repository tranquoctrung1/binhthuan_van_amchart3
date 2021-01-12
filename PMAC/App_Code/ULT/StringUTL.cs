using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PMAC.ULT
{
    /// <summary>
    /// Summary description for StringUTL
    /// </summary>
    public class StringUT
    {
        public StringUT()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        private static readonly string[] VietnameseSigns = new string[]
    {
        "aAeEoOuUiIdDyY",
        "áàạảãâấầậẩẫăắằặẳẵ",
        "ÁÀẠẢÃÂẤẦẬẨẪĂẮẰẶẲẴ",
        "éèẹẻẽêếềệểễ",
        "ÉÈẸẺẼÊẾỀỆỂỄ",
        "óòọỏõôốồộổỗơớờợởỡ",
        "ÓÒỌỎÕÔỐỒỘỔỖƠỚỜỢỞỠ",
        "úùụủũưứừựửữ",
        "ÚÙỤỦŨƯỨỪỰỬỮ",
        "íìịỉĩ",
        "ÍÌỊỈĨ",
        "đ",
        "Đ",
        "ýỳỵỷỹ",
        "ÝỲỴỶỸ"
    };
        public string RemoveSign4VietnameseString(string str)
        {
            for (int i = 1; i < VietnameseSigns.Length; i++)
            {
                for (int j = 0; j < VietnameseSigns[i].Length; j++)
                {
                    str = str.Replace(VietnameseSigns[i][j], VietnameseSigns[0][i - 1]);
                }
            }
            return str;
        }
        private string letters = "abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ0123456789";
        public string HashMD5(string input)
        {
            byte[] pass = System.Text.Encoding.UTF8.GetBytes(input);
            System.Security.Cryptography.MD5 md5 = new System.Security.Cryptography.MD5CryptoServiceProvider();
            string strHash = System.Text.Encoding.UTF8.GetString(md5.ComputeHash(pass));
            return strHash;
        }

        public string CreateSalt(int size)
        {
            string strRd = "";
            Random rdm = new Random();
            for (int i = 0; i < size; i++)
            {
                strRd += letters[rdm.Next(letters.Length - 1)];
            }
            return strRd;
        }
    }
}