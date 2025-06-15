<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.*, tasktrack.models.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel</title>
    <!--TailwindCSS CDN-->
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="bg-gray-100 text-gray-800">
    <div class="max-w-6xl mx-auto p-6 space-y-10">
        <div class="flex justify-between items-center">
            <h1 class="text-3xl font-bold text-indigo-600">Admin Panel</h1>
            <a href="/TaskTrack/logout"
               class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600">
               Logout
            </a>
        </div>

        <div>
            <h2 class="text-2xl font-semibold text-indigo-500 mb-4">Student Progress</h2>
            <div class="overflow-x-auto">
                <table class="min-w-full bg-white shadow rounded">
                    <thead>
                        <tr class="bg-indigo-500 text-white">
                            <th class="px-4 py-2 text-left">Name</th>
                            <th class="px-4 py-2 text-left">Level</th>
                            <th class="px-4 py-2 text-left">Courses Taken</th>
                            <th class="px-4 py-2 text-left">Assignments Completed</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="student" items="${students}">
                            <tr class="border-b hover:bg-gray-50">
                                <td class="px-4 py-2">${student.name}</td>
                                <td class="px-4 py-2">${student.level}</td>
                                <td class="px-4 py-2">
                                    <c:choose>
                                        <c:when test="${empty student.course_names}">
                                            <em class="text-gray-500">No course taken</em>
                                        </c:when>
                                        <c:otherwise>
                                            ${student.course_names}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-4 py-2">${student.completed}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <c:if test="${empty students}">
                    <p class="mt-2 text-gray-500 italic">No student data available.</p>
                </c:if>
            </div>
        </div>

        <div>
            <div class="flex justify-between items-center mb-4">
                <h2 class="text-2xl font-semibold text-indigo-500">Course Management</h2>
                <a href="${pageContext.request.contextPath}/courseList"
                   class="bg-indigo-500 text-white px-4 py-2 rounded hover:bg-indigo-600">
                   Add Course
                </a>
            </div>
            <div class="overflow-x-auto">
                <table class="min-w-full bg-white shadow rounded">
                    <thead>
                        <tr class="bg-indigo-500 text-white">
                            <th class="px-4 py-2 text-left">Name</th>
                            <th class="px-4 py-2 text-left">Description</th>
                            <th class="px-4 py-2 text-left">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="course" items="${courses}">
                            <tr class="border-b hover:bg-gray-50">
                                <td class="px-4 py-2">${course.name}</td>
                                <td class="px-4 py-2">${course.description}</td>
                                <td class="px-4 py-2 space-x-2">
                                    <form method="get" action="${pageContext.request.contextPath}/courseList" class="inline">
                                        <input type="hidden" name="id" value="${course.id}" />
                                        <button type="submit"
                                                class="bg-yellow-400 text-white px-3 py-1 rounded hover:bg-yellow-500">
                                            Edit
                                        </button>
                                    </form>
                                    <form method="post" action="${pageContext.request.contextPath}/deleteCourse" class="inline">
                                        <input type="hidden" name="id" value="${course.id}" />
                                        <button type="submit"
                                                class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600">
                                            Delete
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <c:if test="${empty courses}">
                    <p class="mt-2 text-gray-500 italic">No courses available.</p>
                </c:if>
            </div>
        </div>

        <div>
            <div class="flex justify-between items-center mb-4">
                <h2 class="text-2xl font-semibold text-indigo-500">Assignment Management</h2>
                <a href="${pageContext.request.contextPath}/assignmentList"
                   class="bg-indigo-500 text-white px-4 py-2 rounded hover:bg-indigo-600">
                   Add Assignment
                </a>
            </div>
            <div class="overflow-x-auto">
                <table class="min-w-full bg-white shadow rounded">
                    <thead>
                        <tr class="bg-indigo-500 text-white">
                            <th class="px-4 py-2 text-left">Title</th>
                            <th class="px-4 py-2 text-left">Deadline</th>
                            <th class="px-4 py-2 text-left">Course</th>
                            <th class="px-4 py-2 text-left">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="assignment" items="${assignments}">
                            <tr class="border-b hover:bg-gray-50">
                                <td class="px-4 py-2">${assignment.title}</td>
                                <td class="px-4 py-2">
                                    <fmt:formatDate value="${assignment.deadline}" pattern="dd-MM-yyyy" />
                                </td>
                                <td class="px-4 py-2">${assignment.course_name}</td>
                                <td class="px-4 py-2 space-x-2">
                                    <form method="get" action="${pageContext.request.contextPath}/assignmentList" class="inline">
                                        <input type="hidden" name="id" value="${assignment.id}" />
                                        <button type="submit"
                                                class="bg-yellow-400 text-white px-3 py-1 rounded hover:bg-yellow-500">
                                            Edit
                                        </button>
                                    </form>
                                    <form method="post" action="${pageContext.request.contextPath}/deleteAssignment" class="inline">
                                        <input type="hidden" name="id" value="${assignment.id}" />
                                        <button type="submit"
                                                class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600">
                                            Delete
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <c:if test="${empty assignments}">
                    <p class="mt-2 text-gray-500 italic">No assignments available.</p>
                </c:if>
            </div>
        </div>

        <div>
            <h2 class="text-2xl font-semibold text-indigo-500 mb-2">Assign Role</h2>
            <a href="${pageContext.request.contextPath}/assignRole"
               class="inline-block bg-indigo-500 text-white px-4 py-2 rounded hover:bg-indigo-600">
               Create Admin Role for Student
            </a>
        </div>
    </div>
</body>
</html>
