import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
TreeView treee=TreeView(
  controller: TreeViewController( 
  children:[
    const Node(key: "1", label: "Folder",
    children: [
      Node(key: "1.1", label: "Folder 1"),
      Node(key: "1.2",label: "Folder 2")
     ]
    )
  ] 
) 
);