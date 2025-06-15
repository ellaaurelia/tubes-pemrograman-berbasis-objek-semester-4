<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Assignment Form</title>
    <!--TailwindCSS CDN-->
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="bg-gray-100 text-gray-800">
    <div class="max-w-xl mx-auto mt-10 p-6 bg-white rounded shadow space-y-6">
        <h2 class="text-2xl font-bold text-indigo-600">
            ${assignment != null ? "Edit Assignment" : "Add Assignment"}
        </h2>

        <form action="${pageContext.request.contextPath}/assignmentList" method="post" class="space-y-4">
            <input type="hidden" name="action" value="${assignment != null ? 'edit' : 'add'}"/>
            <c:if test="${assignment != null}">
                <input type="hidden" name="id" value="${assignment.id}"/>
            </c:if>

            <div>
                <label for="title" class="block text-sm font-medium text-gray-700">Title</label>
                <input type="text" id="title" name="title"
                       value="${assignment != null ? assignment.title : ''}"
                       required
                       class="mt-1 block w-full px-3 py-2 border rounded shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"/>
            </div>

            <div>
                <label for="deadline" class="block text-sm font-medium text-gray-700">Deadline</label>
                <input type="date" id="deadline" name="deadline"
                       value="${assignment != null ? assignment.deadline : ''}"
                       required
                       class="mt-1 block w-full px-3 py-2 border rounded shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"/>
            </div>

            <div>
                <label for="courseId" class="block text-sm font-medium text-gray-700">Course</label>
                <select id="courseId" name="courseId" required
                        class="mt-1 block w-full px-3 py-2 border rounded shadow-sm bg-white focus:outline-none focus:ring-indigo-500 focus:border-indigo-500">
                    <c:forEach var="course" items="${courses}">
                        <option value="${course.id}" 
                            <c:if test="${assignment != null && assignment.courseId == course.id}">selected</c:if>>
                            ${course.name}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <button type="submit"
                    class="w-full bg-indigo-500 text-white py-2 px-4 rounded hover:bg-indigo-600 font-semibold">
                ${assignment != null ? "Update" : "Add"} Assignment
            </button>
        </form>

        <a href="${pageContext.request.contextPath}/admin"
           class="inline-block text-sm text-indigo-600 hover:underline mt-4">← Back to Admin Panel</a>
    </div>
</body>
</html>
