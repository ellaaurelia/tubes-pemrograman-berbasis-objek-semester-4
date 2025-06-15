<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Course Form</title>
        <!--TailwindCSS CDN-->
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    </head>
    <body class="bg-gray-100 text-gray-800">
        <div class="max-w-xl mx-auto mt-10 p-6 bg-white rounded shadow space-y-6">
            <h2 class="text-2xl font-bold text-indigo-600">
                ${course != null ? "Edit Course" : "Add Course"}
            </h2>

            <form action="${pageContext.request.contextPath}/${course != null ? 'editCourse' : 'addCourse'}"
                  method="post" class="space-y-4">
                <input type="hidden" name="action" value="${course != null ? 'edit' : 'add'}"/>
                <c:if test="${course != null}">
                    <input type="hidden" name="id" value="${course.id}"/>
                </c:if>

                <div>
                    <label for="name" class="block text-sm font-medium text-gray-700">Course Name</label>
                    <input type="text" id="name" name="name"
                           value="${course != null ? course.name : ''}" required
                           class="mt-1 block w-full px-3 py-2 border rounded shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"/>
                </div>

                <div>
                    <label for="description" class="block text-sm font-medium text-gray-700">Description</label>
                    <textarea id="description" name="description" rows="4" cols="50" required
                              class="mt-1 block w-full px-3 py-2 border rounded shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500">
                        ${course != null ? course.description : ''}
                    </textarea>
                </div>

                <button type="submit"
                        class="w-full bg-indigo-500 text-white py-2 px-4 rounded hover:bg-indigo-600 font-semibold">
                    ${course != null ? "Update" : "Add"} Course
                </button>
            </form>

            <a href="${pageContext.request.contextPath}/admin"
               class="inline-block text-sm text-indigo-600 hover:underline mt-4">← Back to Admin Panel</a>
        </div>
    </body>
</html>
