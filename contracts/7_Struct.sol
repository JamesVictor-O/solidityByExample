// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Library{
     
     struct Book{
        string title;
        string author;
        uint year;
     }

     struct Todo{
        string tasks;
        bool completed;
     }

     Book[] public books;
     Todo[] public  todos;


    //  uint[] public book

     function addBook(string memory _title,string memory _author, uint _year)public{
         books.push(Book(_title,_author, _year));

     }


     function getBook(uint index) view  public returns (Book memory book){
         book=books[index];

        return book;
     }


     function addTodo(string memory _tasks)public{
        todos.push(Todo(_tasks,false));

        // todos.push(Todo({tasks:_tasks,completed:false}));


     }


     function getTodos(uint _index) public view returns(string memory tasks, bool completed){
         Todo storage todo= todos[_index];
          return  (todo.tasks,todo.completed);
     }

     function updateTodoTasks(uint _index,string calldata _newTasks) public{
         Todo storage todo = todos[_index];
         todo.tasks=_newTasks;
     }

     function updateTaskCompletion(uint _index) public{
        Todo storage todo=todos[_index];
        todo.completed= !todo.completed;
     }


}