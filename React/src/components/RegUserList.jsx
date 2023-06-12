import { DataGrid } from "@mui/x-data-grid";
import Button from '@mui/material/Button'
import { userColumns,userRows } from "./RegUserDataTableSource";
import { Link } from "react-router-dom";
import { useState,useEffect } from "react";
import "./UserList.css";
import axios from 'axios';

const RegUserList = () => {
  const [data, setData] = useState(userRows);
  useEffect(() => {
    axios.get('http://localhost:5000/registeredUsers')
    .then(response => {
      console.log(response.data)
      setData(
        response.data.map((row,index)=>{
          return {  id:index+1, 
                    fullName:row.fullName,
                    email:row.email,
                    phoneNo:row.phoneNo,
                    password:row.password,
                    role:row.role,
                    createdDate:row.createdDate
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

  const handleRoleButtonClick = (rowData) => {
    console.log(`Role button clicked for row with ID ${rowData.id}`);
  };

  const actionColumn = [
    {
      field: 'role',
      headerName: 'Role',
      width: 130,
      renderCell: (params) => (
        <Button variant="contained" onClick={() => handleRoleButtonClick(params.row)}>
          {params.row.role}
        </Button>
      ),
    },
    {
      field: "action",
      headerName: "Action",
      width: 200,
      renderCell: (params) => {
        return (
          <div className="cellAction">
            <Link to="/users/test" style={{ textDecoration: "none" }}>
              <div className="viewButton">View</div>
            </Link>
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
        Registered Users
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

export default RegUserList;
