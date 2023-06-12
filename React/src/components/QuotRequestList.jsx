import { DataGrid } from "@mui/x-data-grid";
import { userColumns } from "./QuotRequestDataTableSource ";
import { Link } from "react-router-dom";
import { useState,useEffect } from "react";
import "./List.css";
import axios from 'axios';




const EventGridList = () => {
  const [data, setData] = useState([]);

  useEffect(() => {
    axios.get('http://localhost:5000/quotationRequest')
    .then(response => {
      console.log(response.data)
      setData(
        response.data.map((row,index)=>{
          return {  id:index+1, 
                    firstName:row.firstName,
                    lastName:row.firstName,
                    contactNumber:row.contactNumber,
                    email:row.email,
                    eventStarttime:row.eventStarttime,
                    date:row.date,
                    eventDurationHours:row.eventDurationHours,
                    totalInvitees:row.totalInvitees,
                    remarks:row.remarks
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
        Quotation Requests
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

export default EventGridList;