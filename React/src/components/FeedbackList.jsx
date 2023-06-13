import { DataGrid } from "@mui/x-data-grid";
import { userColumns } from "./FeedbackDataTableSource";
//import { Link } from "react-router-dom";
import { useState,useEffect } from "react";
import "./List.css";
import axios from 'axios';




const FeedbackList = () => {
  const [data, setData] = useState([]);

  useEffect(() => {
    axios.get('http://localhost:3300/feed')
    .then(response => {
      console.log(response.data)
      setData(
        response.data.map((row,index)=>{
          return { 
                   id:index+1,
                   oid:row._id,
                   uid:row.uid,
                   rating:parseFloat(row.rating.$numberDecimal),
                   comment:row.comment
                  }
    }))
    })
    .catch(error => {
      console.log(error);
    });
  }, [])


  const handleDelete = (oid) => {
    axios.get(`http://localhost:3300/feed/deleteFeedback/${oid}`)
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
        Feedbacks
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

export default FeedbackList;