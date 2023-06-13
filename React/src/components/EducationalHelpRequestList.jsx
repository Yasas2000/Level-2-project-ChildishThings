import { DataGrid } from "@mui/x-data-grid";
import { userColumns } from "./EducationalHelpRequestDataTableSource";
//import { Link } from "react-router-dom";
import { useState,useEffect } from "react";
import "./List.css";
import axios from 'axios';



const EducationalHelpRequestList = () => {
  const [data, setData] = useState([]);

  useEffect(() => {
    axios.get('http://localhost:3300/edurequest/list')
    .then(response => {
      console.log(response.data)
      setData(
        response.data.map((row,index)=>{
          return { id:index+1,
                   oid:row._id,
                   userId:row.userId,
                   fullName:row.fullName,
                   telephoneNumber:row.telephoneNumber,
                   email:row.email,
                   purpose:row.purpose,
                   instituteName:row.instituteName,  
                   instituteAddress:row.instituteAddress,
                   instituteEmail:row.instituteEmail,
                   createdAt:row.createdAt,
                   updatedAt:row.updatedAt
                  }
    }))
    })
    .catch(error => {
      console.log(error);
    });
  }, [])


  const handleDelete = (oid) => {
    axios.get(`http://localhost:3300/edurequest/deleteRequest/${oid}`)
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
        Educational Help Requests
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

export default EducationalHelpRequestList;