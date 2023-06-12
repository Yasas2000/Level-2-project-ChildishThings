import { DataGrid } from "@mui/x-data-grid";
import { userColumns } from "./EventDataTableSource";
import { Link } from "react-router-dom";
import { useState,useEffect } from "react";
import "./List.css";
import axios from 'axios';




const EventGridList = () => {
  const [data, setData] = useState([]);

  useEffect(() => {
    axios.get('http://localhost:3300/api/portraitQuotation')
    .then(response => {
      console.log(response.data)
      setData(
        response.data.map((row,index)=>{
          return {  id:index+1, 
                    oid:row._id,
                    date:row.date,
                    eventStarttime:row.eventStarttime,
                    firstName:row.firstName,
                    lastName:row.firstName,
                    contactNumber:row.contactNumber,
                    email:row.email,
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


  const handleDelete = (oid) => {
    axios.get(`http://localhost:3300/events/delete-events/${oid}`)
    .then(response => {
      console.log(response.data);
      // Update your data here if necessary
    })
    .catch(error => {
      console.log(error);
    });
    setData(data.filter((item) => item.oid !== oid));
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
        Events
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