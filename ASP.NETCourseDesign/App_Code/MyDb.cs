using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ASP.NETCourseDesign.App_Code
{
    public class MyDb
    {
        private string connstring = null;
        private SqlConnection conn = null;
        private SqlCommand comm;
        public MyDb()
        {
            connstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            conn = new SqlConnection(connstring);
        }
        public int cud(string sql, SqlParameter[] param)
        {
            conn.Open();
            comm = new SqlCommand(sql, conn);
            if (param.Length > 0)
            {
                foreach (SqlParameter pa in param)
                { comm.Parameters.Add(pa); }
            }
            int i = comm.ExecuteNonQuery();
            conn.Close();
            return i;
        }
        public DataTable GetRecords(string sql, SqlParameter[] param)
        {
            conn.Open();
            SqlCommand comm = new SqlCommand(sql, conn);
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = comm;
            if (param.Length > 0)
            {
                foreach (SqlParameter pa in param)
                { da.SelectCommand.Parameters.Add(pa); }
            }
            DataTable dt = new DataTable();
            da.Fill(dt);
            conn.Close();
            return dt;
        }
        public int cud(string sql)
        {
            SqlParameter[] param = { };
            return cud(sql, param);
        }
        public DataTable GetRecords(string sql)
        {
            SqlParameter[] param = { };
            return GetRecords(sql, param);
        }
        public void close()
        {
            conn.Close();
        }
    }
}
