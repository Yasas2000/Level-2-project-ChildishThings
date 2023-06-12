import { DataGrid } from "@mui/x-data-grid";
import { userColumns } from "./DonationDataTableSource";
//import { Link } from "react-router-dom";
import { useState,useEffect } from "react";
import "./List.css";
import axios from 'axios';




const DonationList = () => {
  const [data, setData] = useState([]);

  useEffect(() => {
    axios.get('http://localhost:5000/donations')
    .then(response => {
      console.log(response.data)
      setData(
        response.data.map((row,index)=>{
          return { id:index+1,
                   donationId:row.id,
                   desc:row.desc,
                   date:row.date,
                  }
    }))
    })
    .catch(error => {
      console.log(error);
    });
  }, [])


  const handleDelete = (id) => {
    setData(data.filter((item) => item.id !== id));
  };

  const actionColumn = [
    {
      field: "action",
      headerName: "Action",
      width: 200,
      renderCell: (params) => {
        return (
          <div className="cellAction">
            <div
              className="deleteButton"
              onClick={() => handleDelete(params.row.id)}
            >
              Delete
            </div>
          </div>
        );
      },
    },
  ];
  return (
    <div className="datatable">
      <div className="datatableTitle">
        Donations
      </div>
      <DataGrid
        className="datagrid"
        rows={data}
        columns={userColumns.concat(actionColumn)}
        pageSize={9}
        rowsPerPageOptions={[9]}
        checkboxSelection
      />
    </div>
  );
};

export default DonationList;