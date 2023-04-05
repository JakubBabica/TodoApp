using Application.Logic;
using Application.LogicInterfaces;
using Domain.DTOs;
using FileData;
using FileData.DAOs;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Test;
[TestClass]
public class Class1
{
    [TestMethod]
    public void testmethod()
    {
        ITodoLogic logic = new TodoLogic(new TodoFileDao(new FileContext()),new UserFileDao(new FileContext()));
        SearchTodoParametersDto dto = new SearchTodoParametersDto("jakub", 1, true, "Help");
        var expectedErrorMessage = "Start date cannot be before the end date";
        Task<Exception> ex = Assert.ThrowsExceptionAsync<Exception>(() => logic.GetAsync(dto));
        Assert.AreEqual(expectedErrorMessage, ex.Result.Message);
    }
}