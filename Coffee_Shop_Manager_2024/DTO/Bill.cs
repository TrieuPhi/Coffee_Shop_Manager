using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Coffee_Shop_Manager_2024.DTO
{
    public class Bill
    {
        public Bill(int id, DateTime? dateCheckIn, DateTime? dateCheckOut, int status)
        {
            this.ID = id;
            this.DateCheckIn = dateCheckIn;
            this.DateCheckOut = dateCheckOut;
            this.Status = status;
        }
        public Bill(DataRow row)
        {
            this.ID = (int)row["id"];
            this.DateCheckIn = (DateTime?)row["dateCheckIn"];

            var dataCheckOutTemp = row["dateCheckOut"];
            if (dataCheckOutTemp.ToString() != "") 
            {
                this.DateCheckOut = (DateTime?)dataCheckOutTemp;    
            }

            this.Status = (int)row["status"];
        }
        private int status; 
        private DateTime? dateCheckOut;
        private DateTime? dateCheckIn; 
        private int iD;

        public int ID { get => iD; set => iD = value; }
        public DateTime? DateCheckIn { get => dateCheckIn; set => dateCheckIn = value; }
        public DateTime? DateCheckOut { get => dateCheckOut; set => dateCheckOut = value; }
        public int Status { get => status; set => status = value; }
    }
}
