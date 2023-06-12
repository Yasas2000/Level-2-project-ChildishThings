import { DataGrid } from "@mui/x-data-grid";
import { userColumns } from "./PortraitQuotRequestDataTableSource";
//import { Link } from "react-router-dom";
import { useState,useEffect } from "react";
import "./List.css";
import axios from 'axios';




const PortraitQuotRequestList = () => {
  const [data, setData] = useState([]);

  useEffect(() => {
    axios.get('http://localhost:3300/api/portraitQuotation')
    .then(response => {
      console.log(response.data)
      setData(
        response.data.map((row,index)=>{
          return {  id:index+1, 
                    oid:row._id,
                    fullName:row.firstName+' '+row.lastName,
                    contactNumber:row.contactNumber,
                    email:row.email,
                    eventStarttime:row.eventStarttime,
                    date:row.date,
                    eventDurationHours:row.eventDurationHours,
                    totInvitees:row.totInvitees,
                    remarks:row.remarks,
                    numSmallFamilies:row.numSmallFamilies,
                    numMarriedCouples:row.numMarriedCouples,
                    numUnMarriedCouples:row.numUnMarriedCouples,
                    numIndividualInvitees:row.numIndividualInvitees
                }
    }))
    })
    .catch(error => {
      console.log(error);
    });
  }, [])


  const handleDelete = (oid) => {
    axios.get(`http://localhost:3300/api/deletePortrait/${oid}`)
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
              onClick={() => handleDelete(params.row.oid)}
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
        Portrait Quotation Requests
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

export default PortraitQuotRequestList;