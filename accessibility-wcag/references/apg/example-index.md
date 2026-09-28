Skip to content





[ARIA Authoring Practices Guide (APG)](/WAI/ARIA/apg/)


How to build accessibility semantics into web patterns and widgets




<a href="https://www.w3.org/" class="home w3c" lang="en"><img src="data:image/svg+xml;base64,PHN2ZyByb2xlPSJpbWciIHdpZHRoPSI0NiIgaGVpZ2h0PSI0NiIgdmVyc2lvbj0iMS4xIiB2aWV3Ym94PSIwIDAgMzYwIDM2MCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiBhcmlhLWxhYmVsbGVkYnk9InczYy1ob21lcGFnZS10aXRsZSI+PHRpdGxlIGlkPSJ3M2MtaG9tZXBhZ2UtdGl0bGUiPlczQyBob21lcGFnZTwvdGl0bGU+PGc+PHBhdGggZD0iTTMwNi44MDAyOCwxNDkuNjA0MjJjLTYuNTc4MzEtNS4yMjE2NC0xNi4xODI1OC00LjExMTI2LTIxLjQwNDM3LDIuNDY3MDUtNi40Njc2Myw4LjE1NDQyLTEyLjM0MjA5LDEzLjA2MjcxLTE5LjAzODk1LDE1LjkxOTUzLTEyLjM1MDcsNS4yNTU2Mi0yMi44MTk4LDMuMDM0NDEtMzIuOTQxMTItNi45OTM0NS05LjkxODA2LTkuODI0NzQtMTkuNTgxNTMtMjAuNTMwNzgtMjguOTU3MDEtMzAuOTA2NzEtNC41ODYwNC01LjA3NzU4LTkuMTgwMjMtMTAuMTYzNjEtMTMuODM0MDctMTUuMTkwNDUtNy45NTEzMS04LjU4NjkxLTE1Ljk0NDc1LTE3LjE0MDE0LTIzLjkzMDE4LTI1LjcwMTgzbC0uNzAzODUtLjc1NDZjLTE3LjM2ODkzLTE4LjU4OTU1LTM1LjMyMjg3LTM3LjgxNTE0LTUyLjY0MTA1LTU3LjEyNTQ2LTEzLjczMjQ0LTE1LjMxNzc1LTM0Ljk1MDAyLTIyLjkwNDY2LTU1LjM2MjQxLTE5LjgzNTk4LTIwLjg2MTc5LDMuMTE5NTctMzcuNzMwNzIsMTYuNDcwNzEtNDcuNTA0NDIsMzcuNTg2NTEtOS40MTc2MiwyMC4zMzU5OC02LjIzMDM5LDQzLjQ0MzkxLDguMzA3MjQsNjAuMzA0MjMsMjUuNTc0ODMsMjkuNjYwNzIsNDcuMTQ4NjQsNTQuMTg0MDcsNzIuNDE3ODMsNzcuMjQ5ODYsMTAuMzMzNDksOS40MjYwOCwyMi44MzcwMSwxNC40NDQzMSwzNi4xNTM4NywxNC41MTIxMSw4LjYzODEuMDQyNTgsMjEuNjU4MzgtLjkzMjE5LDM0Ljk0MTcxLTkuODc1NDgsNS44MTUyNi0zLjkxNjAxLDExLjIzMTg2LTcuOTQyODUsMTMuNjEzOS0xNC4wODg1MiwyLjQyNDQ3LTYuMjg5NTkuMTYwOTgtMTMuNTIwMjgtNS41MTgzOC0xNy41OTc3MS01LjUxMDA3LTMuOTY3Mi0xMi43NDA3NS0zLjY4NzY3LTE3Ljk5NjM3LjY3ODA0LS42NjE0Mi41NTA3NC0xLjM4MjA0LDEuMTg2NzktMi4xNzAwMiwxLjg3MzU4LTguMjU2NSw3LjIzMDY5LTE4LjUzMDc5LDE2LjIzMjg4LTM5LjQ3NzE1LDEuMTk0OC0xOS4xOTEzMi0xMy43ODMzMy0zNC4wNTEwNi0zMS44NDc1MS01MS4yNjc3Ni01Mi43NjgyLTUuNjExNy02LjgxNTctMTEuNDE4MzYtMTMuODY4MzUtMTcuNjIzMzgtMjEuMDczODEtNi42MjkwNi03LjY4ODI1LTguMDYxNjktMTguMjY3MjktMy43Mzg0MS0yNy42MTc0MSwzLjc3MjM5LTguMTM3NjYsMTEuMDUzODItMTguMjU5MTMsMjQuMzc5NTgtMjAuMjUwOTYsMTAuMDk1NjYtMS41MTc2NSwyMS40MTIzOCwyLjUxNzIsMjguMTY4NTksMTAuMDQ1MDcsMTcuNDYyNCwxOS40Nzk3NSwzNS41NTE5NSwzOC44NTc3Miw1My4wNDgwMiw1Ny41ODMwMiw4LjE5NzMsOC43NzM3MSwxNi4zOTQxNSwxNy41NTU1NywyNC41NDkwMiwyNi4zNjMyNiw0LjU2OTI3LDQuOTMzNjYsOS4wNzg5LDkuOTI2MDgsMTMuNjU2MzMsMTQuOTk1MzUsOS42MTI4NywxMC42Mzg2OCwxOS41NDc1NSwyMS42MzMxNSwzMC4wNDIwMywzMi4wMzQzLDE4Ljk0NTc4LDE4Ljc3NTksNDIuNDk0MzUsMjMuNTMxNTIsNjYuMzM5OTYsMTMuMzg0ODIsMTEuNDUyMzMtNC44OTEyMywyMS4yOTM5OS0xMi44MzQwOCwzMC45NTc0NS0yNS4wMTUxOSw1LjIxMzA0LTYuNTY5NDEsNC4xMTEyNi0xNi4xNjU1Mi0yLjQ2NjYxLTIxLjM5NTc3WiIgaWQ9InBhdGgxIj48L3BhdGg+PHBhdGggZD0iTTMzMC42MzYxLDY0Ljk4MzMxYzkuODUwMTEtNC42NzA5LDE3LjU5ODE1LTEzLjQ2MTUyLDE4LjMzNTU0LTI0LjEyNTQzLDEuODczNDQtMTguNTEzMTQtMTMuMzY4MDUtMzYuMjI5ODQtMzUuNzg5NDgtMzguOTY4MTEtMTMuNzY2MjctMS43NDU5OS0yNi41NDEsMi4zMzE0NS0zNS41OTQwOCw5LjgzMzQ5LTQuODQwMTksNC4wMjYzOS02LjE0NTgyLDExLjQ3NzctMS45NDk4NCwxNi43MzMzMiw0LjU4NTg5LDUuNDY3NDksOS44NzU0OCw2LjQyNTA1LDE4LjUzMDY0LDEuNjcwMDIsMy4xMDIzNi0xLjc2MzIsNy43NjQ4MS0zLjIyOTgxLDEyLjg5MzI4LTIuODc0MDMsOS42NzIwNy42NzAwMywxMi40NDM4Nyw5LjM4NDA5LDEyLjE3MjY2LDEzLjM0MjY4LS4wNDI1OC41ODUwMS4wMTcwNiwxNC4wNzk5Mi0xMy42MDUyOSwxMy4xMzkxMmwtNS4xMzcwNy0uMzU1NzljLTUuNzIxNzktLjM5MDIxLTExLjQ0Mzg3LDQuOTU4ODgtMTEuODY3NDYsMTEuMDc4ODktLjQ1ODAxLDYuNTEwNjYsNC4zMDYyMiwxMi4xOTgzMiwxMC4yMzEyNywxMi42MTM5bDYuMzE1MjYuNDMyMTljMTcuMzc3OTgsMS4yMDM4NSwxNS41NjM3NCwxNS45NTMzNSwxNS4xOTkzNSwxOC4zMTAxNy0uMzM5MDIsNi43ODE0My0xMS4yMjM1NSwxOC4yODQzNS0zMC42MzU1LDUuMjA0NDMtNi41ODY2Mi00LjQzMzIyLTUzLjU2NTM4LTYzLjQ0MDcyLTUzLjU2NTM4LTYzLjQ0MDcyLTIyLjI2MDAxLTI4Ljc3ODgzLTYwLjA4MzktMzMuODQ4MDktODkuOTMwOTctMTIuMDQ1NS0zLjI4MDQsMi4zOTg4LTUuNDQyMjYsNS45MzM2Ni02LjA2OTQxLDkuOTYwNS0uNjE4ODQsNC4wMTc3OS4zNTU5Myw4LjA0NDQ4LDIuNzU1MDMsMTEuMzI0ODgsMi4zOTg4LDMuMjgwNCw1LjkzMzgxLDUuNDQyMjYsOS45NTE4OSw2LjA2OTQxLDQuMDQzMTYuNjI3NDUsOC4wNTI3OS0uMzU1OTMsMTEuMzMzNDktMi43NTUwMywyMC4zNjEzNS0xNC44NzY2NSwzOC41MTAyNC02LjAxMDIyLDQ3Ljg0MzE1LDYuMDYxMTEsMCwwLDUwLjQzNzY1LDY0Ljg3MzM1LDYzLjQyNDEsNzEuNzQ3OTYsOC40MjYwOCw0LjQ1OTAzLDE3LjIyNTE2LDcuMDM1ODgsMjYuMTY4LDcuNjU0ODcsMjcuNDQ4MjcsMS44OTg2Niw0NC4xNjQzOC0xMy4yMjQxNCw0OC42NzQ0NS0zMy45NDE0MiwyLjk1OC0xMy41Nzk5Mi01LjgyMzg3LTMwLjU1MDQ4LTE5LjY4MzYxLTM2LjY3MDkzWiIgaWQ9InBhdGgyIj48L3BhdGg+PC9nPjxnPjxwYXRoIGQ9Ik03LjY1NjM4LDI0NS42MjE2NGgxOC42ODczNWMxLjk4MDcsMCwzLjYxMDA2LjQ1NTYsNC44ODQxOSwxLjM1OTA4czIuMTM1MTUsMi4wOTI2NywyLjU5MDc1LDMuNTY3NTlsMTYuNjQ4NzMsNjUuMTUwOWMuOTYxMzksMy4zOTc3LDEuODY4NzQsNy4zMzU5NCwyLjcxODE2LDExLjgwNzAxLjQ1MTc0LTIuMjA4NTEuOTAzNDgtNC4zMTY2MiwxLjM1OTA4LTYuMzMyMDguNDUxNzQtMi4wMDc3My45ODg0Mi0zLjg2MTAyLDEuNjEzOTEtNS41NTk4N2wxOS43MDY2Ni02NS4wNjU5NmMuNDUxNzQtMS4zMDUwMywxLjMyODE5LTIuNDQ3ODksMi42MzMyMi0zLjQ0NDAzLDEuMzAxMTYtLjk4ODQyLDIuODU3MTYtMS40ODI2Myw0LjY3MTg0LTEuNDgyNjNoNi41NDA1N2MxLjk4MDcsMCwzLjU3OTE3LjQ0MDE2LDQuNzk5MjUsMS4zMTI3NSwxLjIxNjIyLjg4MDMxLDIuMDgxMDksMi4wODQ5NSwyLjU5MDc1LDMuNjEzOTJsMTkuNzA2NjYsNjUuMTUwOWMuNTYzNzEsMS42NDQ4LDEuMDg4ODEsMy40MzYzMSwxLjU3MTQ0LDUuMzk3NzEuNDc4NzcsMS45NDU5Ni45NDU5NSw0LjAwMDAyLDEuNDAxNTUsNi4xNTQ0Ny4zOTM4Mi0yLjE1NDQ1LjgwNjk1LTQuMTkzMDcsMS4yMzE2Ny02LjExNTg2cy44NjEwMS0zLjcwNjU4LDEuMzE2NjEtNS4zNTEzOGwxNi42NDg3My02NS4yMzU4NWMuMzkzODItMS4zMDUwMywxLjI1ODY5LTIuNDQ3ODksMi41OTA3NS0zLjQ0NDAzLDEuMzI4MTktLjk4ODQyLDIuODk5NjMtMS40ODI2Myw0LjcxNDMxLTEuNDgyNjNoMTcuNDk4MTZsLTMzLjQ2NzM1LDExMi44MDM2NWgtMjAuMjE2MzJsLTIyLjMzOTg4LTc1LjAwNDIzYy0uMzM5NzctLjk2NTI2LS42Njc5Ni0yLjAzODYyLS45NzY4NC0zLjIyNzgyLS4zMTI3NC0xLjE4OTItLjYxMDA0LTIuNDMyNDQtLjg5MTktMy43Mzc0Ny0uMjg1NzIsMS4zMDUwMy0uNTk0NiwyLjU0ODI4LS45MzQzNywzLjczNzQ3cy0uNjUyNTEsMi4yNjI1Ni0uOTM0MzcsMy4yMjc4MmwtMjIuNzY0NTksNzUuMDA0MjNoLTIwLjEzMTM3TDcuNjU2MzgsMjQ1LjYyMTY0WiIgaWQ9InBhdGgzIj48L3BhdGg+PHBhdGggZD0iTTIxMi4xOTc5NCwyNDQuMzQ3NTFjNS4yMDg1MiwwLDkuODk1OC43NjQ0OCwxNC4wNTc5OCwyLjI5MzQ1LDQuMTYyMTgsMS41Mjg5Nyw3LjY4NzMsMy42MTM5MiwxMC41NzUzNCw2LjIzOTQxLDIuODg4MDUsMi42NDA5NCw1LjEwODEzLDUuNzIyMDQsNi42Njc5OSw5LjI2NjQ2LDEuNTU1OTksMy41MzY3LDIuMzM1OTIsNy4zMTI3OCwyLjMzNTkyLDExLjMzNTk2LDAsMy41Njc1OS0uMzgyMjQsNi43MTA0Ni0xLjE0NjcyLDkuNDI4NjJzLTEuODg0MTgsNS4wOTY1NS0zLjM1NTIzLDcuMTM1MTdjLTEuNDc0OTEsMi4wMzg2Mi0zLjI4NTczLDMuNzY4MzYtNS40MzYzMiw1LjE4MTQ5LTIuMTU0NDUsMS40MTMxMy00LjU4NjksMi41NzkxNi03LjMwNTA2LDMuNDgyNjQsMTIuODUzMzUsNC4zNjI5NiwxOS4yODE5NSwxMy4wNTAyNiwxOS4yODE5NSwyNi4wNzczNSwwLDUuNzIyMDQtMS4wMzQ3NSwxMC43NDkwOS0zLjEwMDQsMTUuMDczNDMtMi4wNjk1MSw0LjMzOTc5LTQuODQxNzIsNy45NzY4Ny04LjMyNDM3LDEwLjkxODk3cy03LjUzMjg2LDUuMTUwNi0xMi4xNDY3OCw2LjYyNTUyYy00LjYxNzc4LDEuNDc0OTEtOS40NzEwOSwyLjIwODUxLTE0LjU2NzY0LDIuMjA4NTEtNS4zODIyNywwLTEwLjEyMzYtLjYyNTQ5LTE0LjIyNzg3LTEuODY4NzQtNC4xMDgxMy0xLjI0MzI1LTcuNzAyNzQtMy4xMjc0My0xMC43ODc3LTUuNjUyNTQtMy4wODg4Mi0yLjUxNzM5LTUuNzQ5MDYtNS42NDQ4Mi03Ljk4NDYtOS4zODIyOS0yLjIzOTM5LTMuNzM3NDctNC4xNTA2LTguMDY5NTQtNS43MzM2Mi0xMi45OTYybDkuMDAzOTEtMy44MjI0MWMyLjM3ODM5LS45NjUyNiw0LjU5ODQ4LTEuMjA0NjQsNi42Njc5OS0uNzE4MTUsMi4wNjU2NS40Nzg3NywzLjUyNTExLDEuNTk4NDYsNC4zNzQ1NCwzLjM1MTM3LDEuMDE5MzEsMS45MjI3OSwyLjA5MjY3LDMuNzIyMDMsMy4yMjc4Miw1LjM4OTk5LDEuMTMxMjgsMS42NzU2OCwyLjQyMDg2LDMuMTUwNTksMy44NjQ4OCw0LjQxNzAxLDEuNDQ0MDIsMS4yODE4NiwzLjEwMDQsMi4yODU3Myw0Ljk2OTE0LDMuMDE5MzJzNC4wMTkzMiwxLjEwNDI1LDYuNDU1NjMsMS4xMDQyNWMzLjAwMDAxLDAsNS42MTc3OS0uNDk0MjEsNy44NTcxOC0xLjQ4MjYzLDIuMjM1NTMtLjk5NjE0LDQuMDg4ODItMi4zMDExNyw1LjU2MzczLTMuOTA3MzYsMS40NzEwNS0xLjYyMTYzLDIuNTc1My0zLjQ0NDAzLDMuMzEyNzYtNS40ODI2NS43MzM1OS0yLjAzODYyLDEuMTA0MjUtNC4wNzcyNCwxLjEwNDI1LTYuMTE1ODYsMC0yLjYwMjMzLS4yNDMyNC00Ljk4MDcyLS43MjIwMS03LjEzNTE3LS40ODI2My0yLjE1NDQ1LTEuNTU5ODUtMy45OTIzLTMuMjI3ODItNS41MjEyNi0xLjY3MTgyLTEuNTI4OTctNC4xMTk3MS0yLjcxODE2LTcuMzQ3NTMtMy41Njc1OXMtNy42MTc4LTEuMjc0MTQtMTMuMTY2MDktMS4yNzQxNHYtMTQuNTI1MTdjNC42NDA5NS0uMDU0MDUsOC40NTE3OC0uNDc4NzcsMTEuNDI0NzctMS4yNzQxNHM1LjMwODkxLTEuOTE1MDcsNy4wMDc3Ni0zLjM1MTM3YzEuNjk4ODUtMS40NTE3NCwyLjg1NzE2LTMuMTU4MzIsMy40ODI2NC01LjE0Mjg4LjYyMTYyLTEuOTg0NTcuOTM0MzctNC4xOTMwNy45MzQzNy02LjYyNTUyLDAtNS4xNTA2LTEuMjg5NTgtOS4wMzQ3OS0zLjg2NDg4LTExLjYzNzEyLTIuNTc5MTYtMi42MDIzMy02LjE4OTIyLTMuOTA3MzYtMTAuODMwMTctMy45MDczNi00LjEzNTE2LDAtNy41OTA3NywxLjE1ODMxLTEwLjM2Mjk5LDMuNDgyNjQtMi43NzYwOCwyLjMyNDM0LTQuNzAyNzMsNS4xODE0OS01Ljc3NjA5LDguNTc5MTktLjkwNzM0LDIuNjAyMzMtMi4xMTE5OCw0LjMwMTE4LTMuNjEwMDYsNS4wOTY1NS0xLjUwMTk0Ljc5NTM3LTMuNjQwOTQuOTY1MjYtNi40MTMxNi41MDk2NmwtMTAuNzg3Ny0xLjg2ODc0Yy43OTE1MS01LjQ5MDM3LDIuMjkzNDUtMTAuMjkzNDksNC41MDE5NS0xNC40MDE2MiwyLjIwODUxLTQuMTAwNDEsNC45ODA3Mi03LjUyODk5LDguMzI0MzctMTAuMjcwMzIsMy4zMzk3OC0yLjc0OTA1LDcuMTQ2NzUtNC44MTg1NiwxMS40MjQ3Ny02LjIwODUzLDQuMjc0MTUtMS4zODIyNSw4Ljg3NjQ5LTIuMDc3MjMsMTMuODAzMTYtMi4wNzcyM1oiIGlkPSJwYXRoNCI+PC9wYXRoPjxwYXRoIGQ9Ik0zMzUuMzgwMDIsMzMxLjA3MzgxYzEuMTg5MiwwLDIuMjA4NTEuNDU1NiwzLjA1NzkzLDEuMzU5MDhsOC45MTg5Niw5LjU5ODVjLTQuMDc3MjQsNS43MjIwNC05LjE4OTIzLDEwLjA3NzI3LTE1LjMzMjEyLDEzLjA4MTE1LTYuMTQ2NzUsMy4wMDM4OC0xMy40MzYzNiw0LjUwMTk1LTIxLjg3MjcsNC41MDE5NS03LjY0NDgzLDAtMTQuNTI1MTctMS40Mjg1OC0yMC42NDEwMy00LjI5MzQ2LTYuMTE1ODYtMi44NTcxNi0xMS4zMTI4LTYuODQ5NDUtMTUuNTg2OTUtMTEuOTY5MTctNC4yNzgwMS01LjEyNzQ0LTcuNTU5ODgtMTEuMjEyNDEtOS44NTMzMy0xOC4yNzAzNi0yLjI5MzQ1LTcuMDQyNTEtMy40NDAxNy0xNC43NjQ1NS0zLjQ0MDE3LTIzLjE0Mjk3LDAtOC40NDAyLDEuMjMxNjctMTYuMTc3NjksMy42OTUtMjMuMjM1NjQsMi40NjMzMy03LjA0MjUxLDUuOTMwNTMtMTMuMTE5NzYsMTAuNDA1NDYtMTguMjE2MzEsNC40NzEwNi01LjA5NjU1LDkuODIyNDQtOS4wNTc5NiwxNi4wNTQxMy0xMS44OTE5NSw2LjIyNzgzLTIuODMzOTksMTMuMDgxMTUtNC4yNDcxMywyMC41NTYwOS00LjI0NzEzLDcuNTg2OTEsMCwxNC4yOTczNywxLjM0MzY0LDIwLjEzMTM3LDQuMDM4NjMsNS44MzAxNCwyLjY4NzI3LDEwLjcwMjc2LDYuMjM5NDEsMTQuNjEwMTEsMTAuNjU2NDJsLTcuNDc0OTQsMTAuNDQ3OTNjLS41MDk2Ni42MjU0OS0xLjA5MjY3LDEuMTg5Mi0xLjc0MTMyLDEuNjk4ODUtLjY1MjUxLjUwOTY2LTEuNTcxNDQuNzY0NDgtMi43NjA2My43NjQ0OHMtMi4zMzU5Mi0uNDU1Ni0zLjQ0MDE3LTEuMzU5MDgtMi40NjMzMy0xLjg5OTYyLTQuMDc3MjQtMi45NzI5OS0zLjY0MDk0LTIuMDY5NTEtNi4wNzMzOS0yLjk3Mjk5Yy0yLjQzNjMxLS45MDM0OC01LjU1MjE1LTEuMzU5MDgtOS4zNDM2OC0xLjM1OTA4LTQuMTM1MTYsMC03Ljg5OTY1Ljg2NDg3LTExLjI5NzM1LDIuNTk0NjEtMy4zOTc3LDEuNzIyMDItNi4zMTY2Myw0LjI0NzEzLTguNzQ5MDgsNy41NTIxNi0yLjQzNjMxLDMuMzIwNDgtNC4zMjA0OCw3LjM2NjgzLTUuNjQ4NjgsMTIuMTU0NS0xLjMzMjA1LDQuNzc5OTUtMS45OTYxNSwxMC4yMzE3MS0xLjk5NjE1LDE2LjM0NzU3LDAsNi4xNjk5MS43MzM1OSwxMS42NjgwMSwyLjIwODUxLDE2LjQ3ODg1LDEuNDcxMDUsNC44MTA4MywzLjQ2NzIsOC44NzI2Myw1Ljk4ODQ1LDEyLjE5MzExLDIuNTE3MzksMy4zMDUwNCw1LjQ3ODc5LDUuODMwMTQsOC44NzY0OSw3LjU1MjE2LDMuMzk3NywxLjcyOTc0LDcuMDUwMjMsMi41OTQ2MSwxMC45NTc1OCwyLjU5NDYxLDIuMzIwNDcsMCw0LjQxNzAxLS4xMjM1NSw2LjI4NTc1LS4zODYxLDEuODY4NzQtLjI0NzExLDMuNjEwMDYtLjcwMjcxLDUuMjIzOTYtMS4zNTkwOCwxLjYxMzkxLS42NDg2NSwzLjEyNzQzLTEuNDgyNjMsNC41NDQ0Mi0yLjUwMTk0LDEuNDEzMTMtMS4wMTkzMSwyLjgzMDEzLTIuMjkzNDUsNC4yNDcxMy0zLjgyMjQxLjU2MzcxLS40NTU2LDEuMTQ2NzItLjgzMzk4LDEuNzQxMzItMS4xNTA1OC41OTQ2LS4zMDg4OCwxLjIwMDc4LS40NjMzMiwxLjgyNjI2LS40NjMzMloiIGlkPSJwYXRoNSI+PC9wYXRoPjwvZz48L3N2Zz4=" /></a> <a href="https://www.w3.org/WAI/" class="home wai" lang="en"><img src="data:image/svg+xml;base64,PHN2ZyByb2xlPSJpbWciIHdpZHRoPSIxNjIuNSIgaGVpZ2h0PSI0NS45IiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAxNjIuNSA0NS45IiBhcmlhLWxhYmVsbGVkYnk9IndhaS1ob21lcGFnZS10aXRsZSI+PHRpdGxlIGlkPSJ3YWktaG9tZXBhZ2UtdGl0bGUiPldlYiBBY2Nlc3NpYmlsaXR5IEluaXRpYXRpdmUgKFdBSSkgaG9tZXBhZ2U8L3RpdGxlPjxnPjxwYXRoIGQ9Ik0xLjIgMjQuNWgxNjAiIHN0cm9rZT0iI2VlZDAwOSIgc3Ryb2tlLWxpbmVjYXA9InNxdWFyZSIgc3Ryb2tlLXdpZHRoPSIyIj48L3BhdGg+PGc+PHBhdGggZD0iTTE1Ljc0MSAxNS41aC0xLjgxNkwxMS4xNCA2LjE0NWMtLjQxLTEuMzk0LS42NS0yLjMzNC0uNzIyLTIuODIzLS4xMDQuNzQ5LS4zMzIgMS43MS0uNjg0IDIuODgxTDcuMDQgMTUuNUg1LjIyM0wxLjQ0NCAxLjIyM0gzLjMybDIuMjE3IDguNzJjLjMgMS4xNC41MjcgMi4yNzIuNjg0IDMuMzk5LjE0My0xLjA2OC4zOTctMi4yMzcuNzYxLTMuNTA2bDIuNTItOC42MTNoMS44NTVsMi42MjcgOC42ODFjLjMzOSAxLjEyNy42IDIuMjcyLjc4MSAzLjQzOC4xMDUtLjg5OS4zMzYtMi4wMzguNjk0LTMuNDE4bDIuMjA3LTguNzAxaDEuODc1em0xMC4xMjcuMTk1Yy0xLjYwOCAwLTIuODctLjQ4Ni0zLjc4NC0xLjQ2LS45MTUtLjk3My0xLjM3Mi0yLjMxMi0xLjM3Mi00LjAxOCAwLTEuNzE5LjQyNi0zLjA4OCAxLjI3OS00LjEwNy44NTMtMS4wMTkgMi4wMDUtMS41MjggMy40NTctMS41MjggMS4zNDggMCAyLjQyMi40MzUgMy4yMjMgMS4zMDQuOC44NjkgMS4yIDIuMDQ2IDEuMiAzLjUzdjEuMDY0aC03LjM0M2MuMDMzIDEuMjE4LjM0MiAyLjE0Mi45MjggMi43NzQuNTg2LjYzMSAxLjQxNi45NDcgMi40OS45NDdhOC40NiA4LjQ2IDAgMDAxLjYzMS0uMTUxYy41MTQtLjEwMSAxLjExNi0uMjk4IDEuODA3LS41OTF2MS41NDNhOC41MDYgOC41MDYgMCAwMS0xLjY3LjUzN2MtLjUyMS4xMDQtMS4xMzYuMTU2LTEuODQ2LjE1NnptLS40NC05LjY3N2MtLjg0IDAtMS41MDMuMjctMS45OTIuODEtLjQ4OC41NC0uNzc4IDEuMjkyLS44NjkgMi4yNTZoNS40NmMtLjAxNC0xLjAwMy0uMjQ1LTEuNzY0LS42OTQtMi4yODUtLjQ1LS41MjEtMS4wODQtLjc4MS0xLjkwNC0uNzgxem0xMi4yMzctMS40MTZjMS40MTMgMCAyLjUwMy40ODYgMy4yNzEgMS40Ni43NjkuOTczIDEuMTUzIDIuMzMyIDEuMTUzIDQuMDc3IDAgMS43Ny0uMzkgMy4xNC0xLjE3MiA0LjEwNi0uNzgxLjk2Ny0xLjg2NSAxLjQ1LTMuMjUyIDEuNDUtLjcyMyAwLTEuMzY3LS4xMy0xLjkzNC0uMzlhMy4zODQgMy4zODQgMCAwMS0xLjM4Ni0xLjE2MmgtLjEzN2E0OC4xNjUgNDguMTY1IDAgMDEtLjM2MiAxLjM1N2gtMS4yNlYuMzA1aDEuNzU5djMuNjkxYzAgLjczNi0uMDMzIDEuNDcxLS4wOTggMi4yMDdoLjA5OGMuNzIyLTEuMDY4IDEuODI5LTEuNjAxIDMuMzItMS42MDF6bS0uMjkzIDEuNDU1Yy0xLjA4IDAtMS44NTYuMzA2LTIuMzI0LjkxOC0uNDcuNjEyLS43MDMgMS42NDctLjcwMyAzLjEwNXYuMDc4YzAgMS40NjUuMjM5IDIuNTEyLjcxNyAzLjE0LjQ3OS42MjggMS4yNjIuOTQyIDIuMzQ5Ljk0Mi45NjMgMCAxLjY4MS0uMzUzIDIuMTUzLTEuMDYuNDcyLS43MDYuNzA4LTEuNzI2LjcwOC0zLjA2IDAtMS4zNTUtLjIzNy0yLjM3LS43MTMtMy4wNDgtLjQ3NS0uNjc3LTEuMjA0LTEuMDE1LTIuMTg3LTEuMDE1ek01OS4yODYgMTUuNWwtMS43MTktNC40MjRoLTUuNjY0bC0xLjcgNC40MjRoLTEuODE2bDUuNTc3LTE0LjMzNmgxLjYyTDYxLjE1MiAxNS41ek01Ny4wMyA5LjQ4NEw1NS40MyA1LjE1OGwtLjY4NC0yLjEzOGMtLjE5NS43OC0uNCAxLjQ5NC0uNjE1IDIuMTM4bC0xLjYyMSA0LjMyNnptMTAuMTM3IDYuMjExYy0xLjU0MyAwLTIuNzQ0LS40NzMtMy42MDQtMS40Mi0uODYtLjk0OC0xLjI4OS0yLjMwNy0xLjI4OS00LjA3OCAwLTEuNzk3LjQzNS0zLjE4MiAxLjMwNC00LjE1NS44Ny0uOTczIDIuMTA4LTEuNDYgMy43MTYtMS40Ni41MiAwIDEuMDM3LjA1NCAxLjU0OC4xNjEuNTEuMTA4LjkzMi4yNDYgMS4yNjQuNDE1bC0uNTM3IDEuNDY1Yy0uOTA1LS4zMzgtMS42NzYtLjUwOC0yLjMxNC0uNTA4LTEuMDgxIDAtMS44NzkuMzQtMi4zOTMgMS4wMi0uNTE0LjY4MS0uNzcxIDEuNjk1LS43NzEgMy4wNDMgMCAxLjI5NS4yNTcgMi4yODcuNzcxIDIuOTczLjUxNC42ODcgMS4yNzYgMS4wMyAyLjI4NSAxLjAzLjk0NCAwIDEuODcyLS4yMDggMi43ODMtLjYyNHYxLjU2MmMtLjc0Mi4zODQtMS42NjMuNTc2LTIuNzYzLjU3NnptOS42IDBjLTEuNTQ0IDAtMi43NDUtLjQ3My0zLjYwNC0xLjQyLS44Ni0uOTQ4LTEuMjktMi4zMDctMS4yOS00LjA3OCAwLTEuNzk3LjQzNS0zLjE4MiAxLjMwNS00LjE1NS44NjktLjk3MyAyLjEwNy0xLjQ2IDMuNzE1LTEuNDYuNTIxIDAgMS4wMzcuMDU0IDEuNTQ4LjE2MS41MTEuMTA4LjkzMy4yNDYgMS4yNjUuNDE1bC0uNTM3IDEuNDY1Yy0uOTA1LS4zMzgtMS42NzctLjUwOC0yLjMxNS0uNTA4LTEuMDggMC0xLjg3OC4zNC0yLjM5MiAxLjAyLS41MTUuNjgxLS43NzIgMS42OTUtLjc3MiAzLjA0MyAwIDEuMjk1LjI1NyAyLjI4Ny43NzIgMi45NzMuNTE0LjY4NyAxLjI3NiAxLjAzIDIuMjg1IDEuMDMuOTQ0IDAgMS44NzItLjIwOCAyLjc4My0uNjI0djEuNTYyYy0uNzQyLjM4NC0xLjY2My41NzYtMi43NjQuNTc2em05Ljg2MyAwYy0xLjYwOCAwLTIuODctLjQ4Ni0zLjc4NC0xLjQ2LS45MTUtLjk3My0xLjM3My0yLjMxMi0xLjM3My00LjAxOCAwLTEuNzE5LjQyNy0zLjA4OCAxLjI4LTQuMTA3Ljg1My0xLjAxOSAyLjAwNS0xLjUyOCAzLjQ1Ny0xLjUyOCAxLjM0NyAwIDIuNDIyLjQzNSAzLjIyMiAxLjMwNC44MDEuODY5IDEuMjAyIDIuMDQ2IDEuMjAyIDMuNTN2MS4wNjRIODMuMjljLjAzMiAxLjIxOC4zNDIgMi4xNDIuOTI4IDIuNzc0LjU4Ni42MzEgMS40MTYuOTQ3IDIuNDkuOTQ3YTguNDYgOC40NiAwIDAwMS42My0uMTUxYy41MTUtLjEwMSAxLjExNy0uMjk4IDEuODA3LS41OTF2MS41NDNhOC41MDYgOC41MDYgMCAwMS0xLjY3LjUzN2MtLjUyLjEwNC0xLjEzNi4xNTYtMS44NDUuMTU2em0tLjQ0LTkuNjc3Yy0uODQgMC0xLjUwNC4yNy0xLjk5Mi44MXMtLjc3OCAxLjI5Mi0uODcgMi4yNTZoNS40NmMtLjAxMy0xLjAwMy0uMjQ0LTEuNzY0LS42OTMtMi4yODUtLjQ1LS41MjEtMS4wODQtLjc4MS0xLjkwNS0uNzgxem0xNC4xNCA2LjUyM2MwIDEuMDAzLS4zNzMgMS43NzktMS4xMjIgMi4zMy0uNzQ5LjU1LTEuOC44MjQtMy4xNTQuODI0LTEuNDEzIDAtMi41MzYtLjIyNC0zLjM3LS42NzRWMTMuNDJjMS4xNzkuNTczIDIuMzE1Ljg2IDMuNDA5Ljg2Ljg4NSAwIDEuNTMtLjE0NCAxLjkzMy0uNDMuNDA0LS4yODcuNjA2LS42NzEuNjA2LTEuMTUzIDAtLjQyMy0uMTk0LS43ODEtLjU4MS0xLjA3NC0uMzg4LS4yOTMtMS4wNzYtLjYyOC0yLjA2Ni0xLjAwNi0xLjAwOS0uMzktMS43MTktLjcyNC0yLjEyOS0xLS40MS0uMjc3LS43MTEtLjU4OC0uOTAzLS45MzMtLjE5Mi0uMzQ1LS4yODgtLjc2NS0uMjg4LTEuMjYgMC0uODguMzU4LTEuNTcyIDEuMDc0LTIuMDguNzE2LS41MDggMS43LS43NjIgMi45NS0uNzYyYTguMTcgOC4xNyAwIDAxMy40MTcuNzIzTDk5LjUxMSA2LjdjLTEuMDg4LS40NTYtMi4wNjgtLjY4My0yLjk0LS42ODMtLjczIDAtMS4yODIuMTE1LTEuNjYuMzQ2LS4zNzguMjMxLS41NjYuNTQ5LS41NjYuOTUyIDAgLjM5MS4xNjIuNzE1LjQ4OC45NzIuMzI1LjI1NyAxLjA4NC42MTQgMi4yNzUgMS4wNy44OTIuMzMxIDEuNTUxLjY0IDEuOTc4LjkyNy40MjYuMjg3Ljc0LjYwOS45NDIuOTY3LjIwMi4zNTguMzAzLjc4OC4zMDMgMS4yODl6bTkuNTggMGMwIDEuMDAzLS4zNzMgMS43NzktMS4xMjIgMi4zMy0uNzQ5LjU1LTEuOC44MjQtMy4xNTQuODI0LTEuNDEzIDAtMi41MzYtLjIyNC0zLjM3LS42NzRWMTMuNDJjMS4xNzkuNTczIDIuMzE1Ljg2IDMuNDA5Ljg2Ljg4NSAwIDEuNTMtLjE0NCAxLjkzMy0uNDMuNDA0LS4yODcuNjA2LS42NzEuNjA2LTEuMTUzIDAtLjQyMy0uMTk0LS43ODEtLjU4MS0xLjA3NC0uMzg4LS4yOTMtMS4wNzYtLjYyOC0yLjA2Ni0xLjAwNi0xLjAwOS0uMzktMS43MTktLjcyNC0yLjEyOS0xLS40MS0uMjc3LS43MS0uNTg4LS45MDMtLjkzMy0uMTkyLS4zNDUtLjI4OC0uNzY1LS4yODgtMS4yNiAwLS44OC4zNTgtMS41NzIgMS4wNzQtMi4wOC43MTYtLjUwOCAxLjctLjc2MiAyLjk1LS43NjJhOC4xNyA4LjE3IDAgMDEzLjQxNy43MjNsLS41OTUgMS4zOTZjLTEuMDg4LS40NTYtMi4wNjctLjY4My0yLjk0LS42ODMtLjcyOSAwLTEuMjgyLjExNS0xLjY2LjM0Ni0uMzc4LjIzMS0uNTY2LjU0OS0uNTY2Ljk1MiAwIC4zOTEuMTYyLjcxNS40ODguOTcyLjMyNS4yNTcgMS4wODQuNjE0IDIuMjc1IDEuMDcuODkyLjMzMSAxLjU1MS42NCAxLjk3OC45MjcuNDI2LjI4Ny43NC42MDkuOTQyLjk2Ny4yMDIuMzU4LjMwMy43ODguMzAzIDEuMjg5em00LjM1NiAyLjk1OWgtMS43NTdWNC43NzdoMS43NTd6bS0xLjg5NC0xMy42MjNjMC0uMzkuMS0uNjc0LjI5OC0uODUuMTk4LS4xNzUuNDQ0LS4yNjMuNzM3LS4yNjMuMjczIDAgLjUxMy4wODguNzE4LjI2My4yMDUuMTc2LjMwNy40Ni4zMDcuODUgMCAuMzg0LS4xMDIuNjY3LS4zMDcuODVhMS4wNDcgMS4wNDcgMCAwMS0uNzE4LjI3MyAxLjA1IDEuMDUgMCAwMS0uNzM3LS4yNzNjLS4xOTktLjE4My0uMjk4LS40NjYtLjI5OC0uODV6bTEwLjM3MSAyLjcyNWMxLjQxMyAwIDIuNTAzLjQ4NiAzLjI3MSAxLjQ2Ljc2OS45NzMgMS4xNTMgMi4zMzIgMS4xNTMgNC4wNzcgMCAxLjc3LS4zOSAzLjE0LTEuMTcyIDQuMTA2LS43ODEuOTY3LTEuODY1IDEuNDUtMy4yNTIgMS40NS0uNzIzIDAtMS4zNjctLjEzLTEuOTM0LS4zOWEzLjM4NCAzLjM4NCAwIDAxLTEuMzg2LTEuMTYyaC0uMTM3YTQ4LjI0NCA0OC4yNDQgMCAwMS0uMzYxIDEuMzU3aC0xLjI2Vi4zMDVoMS43NTh2My42OTFjMCAuNzM2LS4wMzMgMS40NzEtLjA5OCAyLjIwN2guMDk4Yy43MjItMS4wNjggMS44My0xLjYwMSAzLjMyLTEuNjAxem0tLjI5MyAxLjQ1NWMtMS4wOCAwLTEuODU1LjMwNi0yLjMyNC45MTgtLjQ2OS42MTItLjcwMyAxLjY0Ny0uNzAzIDMuMTA1di4wNzhjMCAxLjQ2NS4yMzkgMi41MTIuNzE3IDMuMTQuNDc5LjYyOCAxLjI2Mi45NDIgMi4zNS45NDIuOTYzIDAgMS42OC0uMzUzIDIuMTUyLTEuMDYuNDcyLS43MDYuNzA4LTEuNzI2LjcwOC0zLjA2IDAtMS4zNTUtLjIzNy0yLjM3LS43MTMtMy4wNDgtLjQ3NS0uNjc3LTEuMjA0LTEuMDE1LTIuMTg3LTEuMDE1em05LjI3NyA5LjQ0M2gtMS43NTdWNC43NzdoMS43NTd6bS0xLjg5NC0xMy42MjNjMC0uMzkuMS0uNjc0LjI5OC0uODUuMTk4LS4xNzUuNDQ0LS4yNjMuNzM3LS4yNjMuMjczIDAgLjUxMy4wODguNzE4LjI2My4yMDUuMTc2LjMwNy40Ni4zMDcuODUgMCAuMzg0LS4xMDIuNjY3LS4zMDcuODVhMS4wNDcgMS4wNDcgMCAwMS0uNzE4LjI3MyAxLjA1IDEuMDUgMCAwMS0uNzM3LS4yNzNjLS4xOTktLjE4My0uMjk4LS40NjYtLjI5OC0uODV6bTcuMDUgMTMuNjIzaC0xLjc1N1YuMzA1aDEuNzU4em01LjE1NyAwaC0xLjc1OFY0Ljc3N2gxLjc1OHptLTEuODk1LTEzLjYyM2MwLS4zOS4xLS42NzQuMjk4LS44NS4xOTktLjE3NS40NDQtLjI2My43MzctLjI2My4yNzQgMCAuNTEzLjA4OC43MTguMjYzLjIwNS4xNzYuMzA4LjQ2LjMwOC44NSAwIC4zODQtLjEwMy42NjctLjMwOC44NWExLjA0NyAxLjA0NyAwIDAxLS43MTguMjczIDEuMDUgMS4wNSAwIDAxLS43MzctLjI3M2MtLjE5OC0uMTgzLS4yOTgtLjQ2Ni0uMjk4LS44NXptOC44NzcgMTIuMzgzYy4yMjggMCAuNDk1LS4wMjMuODAxLS4wNjkuMzA2LS4wNDUuNTM3LS4wOTcuNjkzLS4xNTZ2MS4zNDhjLS4xNjIuMDcxLS40MTUuMTQxLS43NTYuMjFhNS4yOSA1LjI5IDAgMDEtMS4wNC4xMDJjLTIuMDk3IDAtMy4xNDUtMS4xMDMtMy4xNDUtMy4zMXYtNi4yNGgtMS41MTR2LS44NGwxLjUzNC0uNzAzLjcwMy0yLjI4NmgxLjA0NXYyLjQ2MWgzLjA5NXYxLjM2OGgtMy4wOTV2Ni4xOWMwIC42Mi4xNDggMS4wOTUuNDQ0IDEuNDI3LjI5Ni4zMzIuNzA4LjQ5OCAxLjIzNS40OTh6bTEuOTUzLTkuNDgzaDEuODg1bDIuMzE1IDYuMTA0Yy40ODggMS4zMjguNzg3IDIuMzAxLjg5OCAyLjkyaC4wNzhjLjA1OS0uMjQxLjE5Mi0uNjkyLjQtMS4zNTMuMjA5LS42Ni4zODUtMS4xOS41MjgtMS41ODdsMi4xNzgtNi4wODRoMS44OTRsLTQuNjE5IDEyLjIwN2MtLjQ1IDEuMTg1LS45ODMgMi4wMzUtMS42MDIgMi41NS0uNjE4LjUxNC0xLjM4My43Ny0yLjI5NC43Ny0uNDg5IDAtLjk3NC0uMDU1LTEuNDU2LS4xNjV2LTEuMzk3Yy4zMjYuMDc4LjcxNy4xMTcgMS4xNzIuMTE3LjU2IDAgMS4wMzUtLjE1NCAxLjQyNi0uNDYzLjM5LS4zMS43MS0uNzg3Ljk1Ny0xLjQzMWwuNTU3LTEuNDI2ek03LjE1NyA0NS41SDIuMDAxdi0xLjAzNWwxLjY4LS4zODFWMzIuNjU4bC0xLjY4LS40di0xLjAzNWg1LjE1NnYxLjAzNWwtMS42OC40djExLjQyNmwxLjY4LjM4em05LjgyNCAwdi02Ljg1NWMwLS44NzMtLjE5My0xLjUyMi0uNTgtMS45NDktLjM4OC0uNDI2LS45OTUtLjY0LTEuODIyLS42NC0xLjEgMC0xLjkuMzA1LTIuMzk4LjkxNC0uNDk4LjYwOC0uNzQ3IDEuNi0uNzQ3IDIuOTczVjQ1LjVIOS42NzdWMzQuNzc3aDEuNDE2bC4yNjMgMS40NjVoLjA5OGEzLjMxIDMuMzEgMCAwMTEuMzk2LTEuMjI1IDQuNDkyIDQuNDkyIDAgMDExLjk4My0uNDM1YzEuMzE1IDAgMi4yOTIuMzE5IDIuOTMuOTU3LjYzOC42MzguOTU3IDEuNjMuOTU3IDIuOTc5VjQ1LjV6bTYuODE3IDBIMjIuMDRWMzQuNzc3aDEuNzU4em0tMS44OTUtMTMuNjIzYzAtLjM5LjEtLjY3NC4yOTgtLjg1LjE5OS0uMTc1LjQ0NC0uMjYzLjczNy0uMjYzLjI3NCAwIC41MTMuMDg4LjcxOC4yNjMuMjA1LjE3Ni4zMDguNDYuMzA4Ljg1IDAgLjM4NC0uMTAzLjY2Ny0uMzA4Ljg1YTEuMDQ3IDEuMDQ3IDAgMDEtLjcxOC4yNzMgMS4wNSAxLjA1IDAgMDEtLjczNy0uMjczYy0uMTk5LS4xODMtLjI5OC0uNDY2LS4yOTgtLjg1ek0zMC43OCA0NC4yNmMuMjI4IDAgLjQ5NS0uMDIzLjgtLjA2OS4zMDctLjA0NS41MzgtLjA5Ny42OTQtLjE1NnYxLjM0OGMtLjE2My4wNzEtLjQxNS4xNDEtLjc1Ny4yMWE1LjI5IDUuMjkgMCAwMS0xLjA0LjEwMmMtMi4wOTYgMC0zLjE0NC0xLjEwMy0zLjE0NC0zLjMxdi02LjI0aC0xLjUxNHYtLjg0bDEuNTMzLS43MDMuNzAzLTIuMjg2SDI5LjF2Mi40NjFoMy4wOTZ2MS4zNjhIMjkuMXY2LjE5YzAgLjYyLjE0OSAxLjA5NS40NDUgMS40MjcuMjk2LjMzMi43MDguNDk4IDEuMjM1LjQ5OHptNS4zOSAxLjI0aC0xLjc1N1YzNC43NzdoMS43NTh6bS0xLjg5NC0xMy42MjNjMC0uMzkuMS0uNjc0LjI5OC0uODUuMTk5LS4xNzUuNDQ0LS4yNjMuNzM3LS4yNjMuMjc0IDAgLjUxMy4wODguNzE4LjI2My4yMDUuMTc2LjMwOC40Ni4zMDguODUgMCAuMzg0LS4xMDMuNjY3LS4zMDguODVhMS4wNDcgMS4wNDcgMCAwMS0uNzE4LjI3MyAxLjA1IDEuMDUgMCAwMS0uNzM3LS4yNzNjLS4xOTktLjE4My0uMjk4LS40NjYtLjI5OC0uODV6TTQ2LjE5IDQ1LjVsLS4zNDItMS41MjNoLS4wNzhjLS41MzQuNjctMS4wNjYgMS4xMjQtMS41OTYgMS4zNjItLjUzLjIzNy0xLjIuMzU2LTIuMDA3LjM1Ni0xLjA1NSAwLTEuODgyLS4yNzYtMi40OC0uODMtLjYtLjU1My0uOS0xLjMzNC0uOS0yLjM0NCAwLTIuMTc0IDEuNzE2LTMuMzEzIDUuMTQ3LTMuNDE3bDEuODE3LS4wNjlWMzguNGMwLS44MTMtLjE3Ni0xLjQxNC0uNTI4LTEuODAxLS4zNTEtLjM4OC0uOTE0LS41ODEtMS42ODktLjU4MS0uNTY2IDAtMS4xMDIuMDg0LTEuNjA2LjI1My0uNTA1LjE3LS45NzkuMzU5LTEuNDIxLjU2N2wtLjUzNy0xLjMxOGE3Ljk1OCA3Ljk1OCAwIDAxMS43NjctLjY3NCA3LjY0MiA3LjY0MiAwIDAxMS44OTUtLjI0NGMxLjI5NSAwIDIuMjU5LjI4NiAyLjg5Ljg1OS42MzIuNTczLjk0OCAxLjQ4NC45NDggMi43MzRWNDUuNXptLTMuNjIzLTEuMjJjLjk4MyAwIDEuNzU2LS4yNjYgMi4zMi0uNzk3LjU2My0uNTMuODQ0LTEuMjg0Ljg0NC0yLjI2di0uOTY3bC0xLjU4Mi4wNjhjLTEuMjMuMDQ2LTIuMTI3LjI0MS0yLjY5LjU4Ni0uNTYzLjM0NS0uODQ1Ljg4OS0uODQ1IDEuNjMxIDAgLjU2LjE3MS45OS41MTMgMS4yOS4zNDIuMjk5LjgyMi40NDggMS40NC40NDh6bTExLjgwNy0uMDJjLjIyOCAwIC40OTUtLjAyMy44LS4wNjkuMzA3LS4wNDUuNTM4LS4wOTcuNjk0LS4xNTZ2MS4zNDhjLS4xNjMuMDcxLS40MTUuMTQxLS43NTcuMjFhNS4yOSA1LjI5IDAgMDEtMS4wNC4xMDJjLTIuMDk2IDAtMy4xNDQtMS4xMDMtMy4xNDQtMy4zMXYtNi4yNGgtMS41MTR2LS44NGwxLjUzMy0uNzAzLjcwMy0yLjI4NmgxLjA0NXYyLjQ2MWgzLjA5NnYxLjM2OGgtMy4wOTZ2Ni4xOWMwIC42Mi4xNDggMS4wOTUuNDQ0IDEuNDI3LjI5Ny4zMzIuNzA4LjQ5OCAxLjIzNi40OTh6bTUuMzkgMS4yNGgtMS43NTdWMzQuNzc3aDEuNzU3ek01Ny44NyAzMS44NzdjMC0uMzkuMS0uNjc0LjI5OC0uODUuMTk4LS4xNzUuNDQ0LS4yNjMuNzM3LS4yNjMuMjc0IDAgLjUxMy4wODguNzE4LjI2My4yMDUuMTc2LjMwNy40Ni4zMDcuODUgMCAuMzg0LS4xMDIuNjY3LS4zMDcuODVhMS4wNDcgMS4wNDcgMCAwMS0uNzE4LjI3MyAxLjA1IDEuMDUgMCAwMS0uNzM3LS4yNzNjLS4xOTktLjE4My0uMjk4LS40NjYtLjI5OC0uODV6TTY1LjUyNiA0NS41bC00LjA2Mi0xMC43MjNoMS44ODRsMi4yNzYgNi4zMTljLjQ1IDEuMjcuNzM2IDIuMjE2Ljg2IDIuODQyaC4wNzdhMTEuNDk1IDExLjQ5NSAwIDAxLjE3Ni0uNjRjLjA0LS4xMjcuMjgtLjg2MS43MjMtMi4yMDJsMi4yODUtNi4zMTloMS44NzVMNjcuNTQ4IDQ1LjV6bTEyLjM1NC4xOTVjLTEuNjA4IDAtMi44Ny0uNDg2LTMuNzg0LTEuNDYtLjkxNS0uOTczLTEuMzczLTIuMzEyLTEuMzczLTQuMDE4IDAtMS43MTkuNDI3LTMuMDg4IDEuMjgtNC4xMDcuODUzLTEuMDE5IDIuMDA1LTEuNTI4IDMuNDU3LTEuNTI4IDEuMzQ3IDAgMi40MjIuNDM1IDMuMjIyIDEuMzA0LjgwMS44NjkgMS4yMDIgMi4wNDYgMS4yMDIgMy41M3YxLjA2NEg3NC41NGMuMDMyIDEuMjE4LjM0MiAyLjE0Mi45MjggMi43NzQuNTg2LjYzMSAxLjQxNi45NDcgMi40OS45NDdhOC40NiA4LjQ2IDAgMDAxLjYzLS4xNTFjLjUxNS0uMTAxIDEuMTE3LS4yOTggMS44MDctLjU5MXYxLjU0M2E4LjUwNiA4LjUwNiAwIDAxLTEuNjcuNTM3Yy0uNTIuMTA0LTEuMTM2LjE1Ni0xLjg0NS4xNTZ6bS0uNDQtOS42NzdjLS44NCAwLTEuNTA0LjI3LTEuOTkyLjgxcy0uNzc4IDEuMjkyLS44NyAyLjI1Nmg1LjQ2Yy0uMDEzLTEuMDAzLS4yNDQtMS43NjQtLjY5My0yLjI4NS0uNDUtLjUyMS0xLjA4NC0uNzgxLTEuOTA1LS43ODF6TTEzNy43NDEgNDUuNWgtMS44MTZsLTIuNzg0LTkuMzU1Yy0uNDEtMS4zOTQtLjY1LTIuMzM0LS43MjItMi44MjMtLjEwNC43NDktLjMzMiAxLjcxLS42ODQgMi44ODFMMTI5LjA0IDQ1LjVoLTEuODE3bC0zLjc3OS0xNC4yNzdoMS44NzVsMi4yMTcgOC43MmMuMyAxLjE0LjUyNyAyLjI3Mi42ODQgMy4zOTkuMTQzLTEuMDY4LjM5Ny0yLjIzNy43NjEtMy41MDZsMi41Mi04LjYxM2gxLjg1NWwyLjYyNyA4LjY4MWMuMzM5IDEuMTI3LjYgMi4yNzIuNzgxIDMuNDM4LjEwNS0uODk5LjMzNi0yLjAzOC42OTQtMy40MThsMi4yMDctOC43MDFoMS44NzV6bTE0LjU3IDBsLTEuNzE4LTQuNDI0aC01LjY2NGwtMS43IDQuNDI0aC0xLjgxNmw1LjU3Ni0xNC4zMzZoMS42MjFsNS41NjcgMTQuMzM2em0tMi4yNTYtNi4wMTZsLTEuNjAxLTQuMzI2LS42ODQtMi4xMzhjLS4xOTUuNzgtLjQgMS40OTQtLjYxNSAyLjEzOGwtMS42MjEgNC4zMjZ6bTEwLjA5OCA2LjAxNmgtNS4xNTZ2LTEuMDM1bDEuNjgtLjM4MVYzMi42NThsLTEuNjgtLjR2LTEuMDM1aDUuMTU2djEuMDM1bC0xLjY4LjR2MTEuNDI2bDEuNjguMzh6Ij48L3BhdGg+PC9nPjwvZz48L3N2Zz4=" /></a>







- [APG Home](/WAI/ARIA/apg/)
- [Patterns](/WAI/ARIA/apg/patterns/)
- [Practices](/WAI/ARIA/apg/practices/)
- <a href="/WAI/ARIA/apg/example-index/" class="active" aria-current="page">Index</a>
- [About](/WAI/ARIA/apg/about/)
- [All WCAG 2 Guidance <img src="data:image/svg+xml;base64,PHN2ZyBmb2N1c2FibGU9ImZhbHNlIiBhcmlhLWhpZGRlbj0idHJ1ZSIgY2xhc3M9Imljb24tZGlmZmVyZW50LXZpZXcgIj48dXNlIHhsaW5rOmhyZWY9Ii9XQUkvYXNzZXRzL2ltYWdlcy9pY29ucy5zdmcjaWNvbi1kaWZmZXJlbnQtdmlldyI+PC91c2U+PC9zdmc+" class="icon-different-view" />](https://www.w3.org/WAI/standards-guidelines/wcag/docs/)




## Page Contents


- [About the Index](#abouttheindex)
- [Examples by Role](#examples_by_role_label)
- [Examples By Properties and States](#examples_by_props_label)
- [Experimental Examples](#examples_experimental_label)




# APG Example Index





## About the Index

This page includes a list of all ARIA design pattern examples indexed either by role or by ARIA properties and states.

- [Examples by Role](#examples_by_role_label)
- [Examples by Properties and States](#examples_by_props_label)
- [Experimental Examples](#examples_experimental_label)


## Examples by Role


**NOTE:** The HC abbreviation means example has High Contrast support.


<table class="data attributes" aria-labelledby="examples_by_role_label">
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr class="header">
<th>Role</th>
<th>Examples</th>
</tr>
</thead>
<tbody id="examples_by_role_tbody">
<tr class="odd">
<td><code>alert</code></td>
<td><ul>
<li><a href="../alert/examples/alert.html">Alert</a></li>
<li><a href="../alertdialog/examples/alertdialog.html">Alert Dialog</a></li>
</ul></td>
</tr>
<tr class="even">
<td><code>alertdialog</code></td>
<td><a href="../alertdialog/examples/alertdialog.html">Alert Dialog</a></td>
</tr>
<tr class="odd">
<td><code>article</code></td>
<td><ul>
<li><a href="../disclosure/examples/disclosure-card.html">Disclosure (Show/Hide) Card</a> (HC)</li>
<li><a href="../feed/examples/feed.html">Infinite Scrolling Feed</a></li>
</ul></td>
</tr>
<tr class="even">
<td><code>banner</code></td>
<td><ul>
<li><a href="../menubar/examples/menubar-navigation.html">Navigation Menubar</a> (HC)</li>
<li><a href="../treeview/examples/treeview-navigation.html">Navigation Treeview</a> (HC)</li>
<li><a href="../landmarks/examples/banner.html.html">Banner Landmark</a></li>
</ul></td>
</tr>
<tr class="odd">
<td><code>button</code></td>
<td><ul>
<li><a href="../button/examples/button_idl.html">Button (IDL Version)</a></li>
<li><a href="../button/examples/button.html">Button</a></li>
</ul></td>
</tr>
<tr class="even">
<td><code>cell</code></td>
<td><a href="../table/examples/table.html">Table</a></td>
</tr>
<tr class="odd">
<td><code>checkbox</code></td>
<td><ul>
<li><a href="../checkbox/examples/checkbox-mixed.html">Checkbox (Mixed-State)</a> (HC)</li>
<li><a href="../checkbox/examples/checkbox.html">Checkbox (Two State)</a> (HC)</li>
</ul></td>
</tr>
<tr class="even">
<td><code>columnheader</code></td>
<td><a href="../table/examples/table.html">Table</a></td>
</tr>
<tr class="odd">
<td><code>combobox</code></td>
<td><ul>
<li><a href="../combobox/examples/combobox-autocomplete-both.html">Editable Combobox With Both List and Inline Autocomplete</a> (HC)</li>
<li><a href="../combobox/examples/combobox-autocomplete-list.html">Editable Combobox With List Autocomplete</a> (HC)</li>
<li><a href="../combobox/examples/combobox-autocomplete-none.html">Editable Combobox without Autocomplete</a> (HC)</li>
<li><a href="../combobox/examples/combobox-datepicker.html">Date Picker Combobox</a> (HC)</li>
<li><a href="../combobox/examples/combobox-select-only.html">Select-Only Combobox</a></li>
<li><a href="../combobox/examples/grid-combo.html">Editable Combobox with Grid Popup</a></li>
</ul></td>
</tr>
<tr class="even">
<td><code>complementary</code></td>
<td><a href="../landmarks/examples/complementary.html.html">Complementary Landmark</a></td>
</tr>
<tr class="odd">
<td><code>contentinfo</code></td>
<td><ul>
<li><a href="../menubar/examples/menubar-navigation.html">Navigation Menubar</a> (HC)</li>
<li><a href="../treeview/examples/treeview-navigation.html">Navigation Treeview</a> (HC)</li>
<li><a href="../landmarks/examples/contentinfo.html.html">Contentinfo Landmark</a></li>
</ul></td>
</tr>
<tr class="even">
<td><code>dialog</code></td>
<td><ul>
<li><a href="../combobox/examples/combobox-datepicker.html">Date Picker Combobox</a> (HC)</li>
<li><a href="../dialog-modal/examples/datepicker-dialog.html">Date Picker Dialog</a> (HC)</li>
<li><a href="../dialog-modal/examples/dialog.html">Modal Dialog</a></li>
</ul></td>
</tr>
<tr class="odd">
<td><code>feed</code></td>
<td><a href="../feed/examples/feed.html">Infinite Scrolling Feed</a></td>
</tr>
<tr class="even">
<td><code>form</code></td>
<td><a href="../landmarks/examples/form.html.html">Form Landmark</a></td>
</tr>
<tr class="odd">
<td><code>grid</code></td>
<td><ul>
<li><a href="../combobox/examples/combobox-datepicker.html">Date Picker Combobox</a> (HC)</li>
<li><a href="../combobox/examples/grid-combo.html">Editable Combobox with Grid Popup</a></li>
<li><a href="../dialog-modal/examples/datepicker-dialog.html">Date Picker Dialog</a> (HC)</li>
<li><a href="../grid/examples/data-grids.html">Data Grid</a></li>
<li><a href="../grid/examples/layout-grids.html">Layout Grid</a></li>
</ul></td>
</tr>
<tr class="even">
<td><code>gridcell</code></td>
<td><ul>
<li><a href="../combobox/examples/grid-combo.html">Editable Combobox with Grid Popup</a></li>
<li><a href="../grid/examples/layout-grids.html">Layout Grid</a></li>
<li><a href="../treegrid/examples/treegrid-1.html">Treegrid Email Inbox</a></li>
</ul></td>
</tr>
<tr class="odd">
<td><code>group</code></td>
<td><ul>
<li><a href="../carousel/examples/carousel-1-prev-next.html">Auto-Rotating Image Carousel with Buttons for Slide Control</a></li>
<li><a href="../checkbox/examples/checkbox.html">Checkbox (Two State)</a> (HC)</li>
<li><a href="../listbox/examples/listbox-grouped.html">Listbox with Grouped Options</a></li>
<li><a href="../menubar/examples/menubar-editor.html">Editor Menubar</a> (HC)</li>
<li><a href="../slider/examples/slider-color-viewer.html">Color Viewer Slider</a> (HC)</li>
<li><a href="../spinbutton/examples/datepicker-spinbuttons.html">(Deprecated) Date Picker Spin Button</a></li>
<li><a href="../switch/examples/switch-button.html">Switch Using HTML Button</a> (HC)</li>
<li><a href="../treeview/examples/treeview-1a.html">File Directory Treeview Using Computed Properties</a></li>
<li><a href="../treeview/examples/treeview-1b.html">File Directory Treeview Using Declared Properties</a></li>
<li><a href="../treeview/examples/treeview-navigation.html">Navigation Treeview</a> (HC)</li>
</ul></td>
</tr>
<tr class="even">
<td><code>link</code></td>
<td><a href="../link/examples/link.html">Link</a></td>
</tr>
<tr class="odd">
<td><code>listbox</code></td>
<td><ul>
<li><a href="../combobox/examples/combobox-autocomplete-both.html">Editable Combobox With Both List and Inline Autocomplete</a> (HC)</li>
<li><a href="../combobox/examples/combobox-autocomplete-list.html">Editable Combobox With List Autocomplete</a> (HC)</li>
<li><a href="../combobox/examples/combobox-autocomplete-none.html">Editable Combobox without Autocomplete</a> (HC)</li>
<li><a href="../combobox/examples/combobox-select-only.html">Select-Only Combobox</a></li>
<li><a href="../listbox/examples/listbox-collapsible.html">(Deprecated) Collapsible Dropdown Listbox</a></li>
<li><a href="../listbox/examples/listbox-grouped.html">Listbox with Grouped Options</a></li>
<li><a href="../listbox/examples/listbox-rearrangeable.html">Listboxes with Rearrangeable Options</a></li>
<li><a href="../listbox/examples/listbox-scrollable.html">Scrollable Listbox</a></li>
</ul></td>
</tr>
<tr class="even">
<td><code>main</code></td>
<td><a href="../landmarks/examples/main.html.html">Main Landmark</a></td>
</tr>
<tr class="odd">
<td><code>menu</code></td>
<td><ul>
<li><a href="../menu-button/examples/menu-button-actions-active-descendant.html">Actions Menu Button Using aria-activedescendant</a> (HC)</li>
<li><a href="../menu-button/examples/menu-button-actions.html">Actions Menu Button Using element.focus()</a> (HC)</li>
<li><a href="../menu-button/examples/menu-button-links.html">Navigation Menu Button</a> (HC)</li>
<li><a href="../menubar/examples/menubar-editor.html">Editor Menubar</a> (HC)</li>
<li><a href="../menubar/examples/menubar-navigation.html">Navigation Menubar</a> (HC)</li>
<li><a href="../toolbar/examples/toolbar.html">Toolbar</a></li>
</ul></td>
</tr>
<tr class="even">
<td><code>menubar</code></td>
<td><ul>
<li><a href="../menubar/examples/menubar-editor.html">Editor Menubar</a> (HC)</li>
<li><a href="../menubar/examples/menubar-navigation.html">Navigation Menubar</a> (HC)</li>
</ul></td>
</tr>
<tr class="odd">
<td><code>menuitem</code></td>
<td><ul>
<li><a href="../menu-button/examples/menu-button-actions-active-descendant.html">Actions Menu Button Using aria-activedescendant</a> (HC)</li>
<li><a href="../menu-button/examples/menu-button-actions.html">Actions Menu Button Using element.focus()</a> (HC)</li>
<li><a href="../menu-button/examples/menu-button-links.html">Navigation Menu Button</a> (HC)</li>
<li><a href="../menubar/examples/menubar-editor.html">Editor Menubar</a> (HC)</li>
<li><a href="../menubar/examples/menubar-navigation.html">Navigation Menubar</a> (HC)</li>
</ul></td>
</tr>
<tr class="even">
<td><code>menuitemcheckbox</code></td>
<td><a href="../menubar/examples/menubar-editor.html">Editor Menubar</a></td>
</tr>
<tr class="odd">
<td><code>menuitemradio</code></td>
<td><ul>
<li><a href="../menubar/examples/menubar-editor.html">Editor Menubar</a> (HC)</li>
<li><a href="../toolbar/examples/toolbar.html">Toolbar</a></li>
</ul></td>
</tr>
<tr class="even">
<td><code>meter</code></td>
<td><a href="../meter/examples/meter.html">Meter</a></td>
</tr>
<tr class="odd">
<td><code>navigation</code></td>
<td><ul>
<li><a href="../menubar/examples/menubar-navigation.html">Navigation Menubar</a> (HC)</li>
<li><a href="../treeview/examples/treeview-navigation.html">Navigation Treeview</a> (HC)</li>
<li><a href="../landmarks/examples/navigation.html.html">Navigation Landmark</a></li>
</ul></td>
</tr>
<tr class="even">
<td><code>none</code></td>
<td><ul>
<li><a href="../menu-button/examples/menu-button-links.html">Navigation Menu Button</a> (HC)</li>
<li><a href="../menubar/examples/menubar-navigation.html">Navigation Menubar</a> (HC)</li>
<li><a href="../radio/examples/radio-rating.html">Rating Radio Group</a> (HC)</li>
<li><a href="../slider-multithumb/examples/slider-multithumb.html">Horizontal Multi-Thumb Slider</a> (HC)</li>
<li><a href="../slider/examples/slider-seek.html">Media Seek Slider</a> (HC)</li>
<li><a href="../slider/examples/slider-temperature.html">Vertical Temperature Slider</a> (HC)</li>
<li><a href="../treeview/examples/treeview-navigation.html">Navigation Treeview</a> (HC)</li>
</ul></td>
</tr>
<tr class="odd">
<td><code>option</code></td>
<td><ul>
<li><a href="../combobox/examples/combobox-autocomplete-both.html">Editable Combobox With Both List and Inline Autocomplete</a> (HC)</li>
<li><a href="../combobox/examples/combobox-autocomplete-list.html">Editable Combobox With List Autocomplete</a> (HC)</li>
<li><a href="../combobox/examples/combobox-autocomplete-none.html">Editable Combobox without Autocomplete</a> (HC)</li>
<li><a href="../combobox/examples/combobox-select-only.html">Select-Only Combobox</a></li>
<li><a href="../listbox/examples/listbox-collapsible.html">(Deprecated) Collapsible Dropdown Listbox</a></li>
<li><a href="../listbox/examples/listbox-grouped.html">Listbox with Grouped Options</a></li>
<li><a href="../listbox/examples/listbox-rearrangeable.html">Listboxes with Rearrangeable Options</a></li>
<li><a href="../listbox/examples/listbox-scrollable.html">Scrollable Listbox</a></li>
</ul></td>
</tr>
<tr class="even">
<td><code>radio</code></td>
<td><ul>
<li><a href="../radio/examples/radio-activedescendant.html">Radio Group Using aria-activedescendant</a> (HC)</li>
<li><a href="../radio/examples/radio-rating.html">Rating Radio Group</a> (HC)</li>
<li><a href="../radio/examples/radio.html">Radio Group Using Roving tabindex</a> (HC)</li>
<li><a href="../toolbar/examples/toolbar.html">Toolbar</a></li>
</ul></td>
</tr>
<tr class="odd">
<td><code>radiogroup</code></td>
<td><ul>
<li><a href="../radio/examples/radio-activedescendant.html">Radio Group Using aria-activedescendant</a> (HC)</li>
<li><a href="../radio/examples/radio-rating.html">Rating Radio Group</a> (HC)</li>
<li><a href="../radio/examples/radio.html">Radio Group Using Roving tabindex</a> (HC)</li>
<li><a href="../toolbar/examples/toolbar.html">Toolbar</a></li>
</ul></td>
</tr>
<tr class="even">
<td><code>region</code></td>
<td><ul>
<li><a href="../accordion/examples/accordion.html">Accordion</a></li>
<li><a href="../carousel/examples/carousel-1-prev-next.html">Auto-Rotating Image Carousel with Buttons for Slide Control</a></li>
<li><a href="../carousel/examples/carousel-2-tablist.html">Auto-Rotating Image Carousel with Tabs for Slide Control</a> (HC)</li>
<li><a href="../menubar/examples/menubar-navigation.html">Navigation Menubar</a> (HC)</li>
<li><a href="../treeview/examples/treeview-navigation.html">Navigation Treeview</a> (HC)</li>
<li><a href="../landmarks/examples/region.html.html">Region Landmark</a></li>
</ul></td>
</tr>
<tr class="odd">
<td><code>row</code></td>
<td><ul>
<li><a href="../combobox/examples/grid-combo.html">Editable Combobox with Grid Popup</a></li>
<li><a href="../grid/examples/layout-grids.html">Layout Grid</a></li>
<li><a href="../table/examples/table.html">Table</a></li>
<li><a href="../treegrid/examples/treegrid-1.html">Treegrid Email Inbox</a></li>
</ul></td>
</tr>
<tr class="even">
<td><code>rowgroup</code></td>
<td><a href="../table/examples/table.html">Table</a></td>
</tr>
<tr class="odd">
<td><code>search</code></td>
<td><a href="../landmarks/examples/search.html.html">Search Landmark</a></td>
</tr>
<tr class="even">
<td><code>separator</code></td>
<td><a href="../menubar/examples/menubar-editor.html">Editor Menubar</a></td>
</tr>
<tr class="odd">
<td><code>slider</code></td>
<td><ul>
<li><a href="../slider-multithumb/examples/slider-multithumb.html">Horizontal Multi-Thumb Slider</a> (HC)</li>
<li><a href="../slider/examples/slider-color-viewer.html">Color Viewer Slider</a> (HC)</li>
<li><a href="../slider/examples/slider-rating.html">Rating Slider</a> (HC)</li>
<li><a href="../slider/examples/slider-seek.html">Media Seek Slider</a> (HC)</li>
<li><a href="../slider/examples/slider-temperature.html">Vertical Temperature Slider</a> (HC)</li>
</ul></td>
</tr>
<tr class="even">
<td><code>spinbutton</code></td>
<td><ul>
<li><a href="../spinbutton/examples/datepicker-spinbuttons.html">(Deprecated) Date Picker Spin Button</a></li>
<li><a href="../spinbutton/examples/quantity-spinbutton.html">Quantity Spin Button</a></li>
<li><a href="../toolbar/examples/toolbar.html">Toolbar</a></li>
</ul></td>
</tr>
<tr class="odd">
<td><code>switch</code></td>
<td><ul>
<li><a href="../switch/examples/switch-button.html">Switch Using HTML Button</a> (HC)</li>
<li><a href="../switch/examples/switch-checkbox.html">Switch Using HTML Checkbox Input</a> (HC)</li>
<li><a href="../switch/examples/switch.html">Switch</a> (HC)</li>
</ul></td>
</tr>
<tr class="even">
<td><code>tab</code></td>
<td><ul>
<li><a href="../carousel/examples/carousel-2-tablist.html">Auto-Rotating Image Carousel with Tabs for Slide Control</a> (HC)</li>
<li><a href="../tabs/examples/tabs-automatic.html">Tabs with Automatic Activation</a> (HC)</li>
<li><a href="../tabs/examples/tabs-manual.html">Tabs with Manual Activation</a> (HC)</li>
</ul></td>
</tr>
<tr class="odd">
<td><code>table</code></td>
<td><a href="../table/examples/table.html">Table</a></td>
</tr>
<tr class="even">
<td><code>tablist</code></td>
<td><ul>
<li><a href="../carousel/examples/carousel-2-tablist.html">Auto-Rotating Image Carousel with Tabs for Slide Control</a> (HC)</li>
<li><a href="../tabs/examples/tabs-automatic.html">Tabs with Automatic Activation</a> (HC)</li>
<li><a href="../tabs/examples/tabs-manual.html">Tabs with Manual Activation</a> (HC)</li>
</ul></td>
</tr>
<tr class="odd">
<td><code>tabpanel</code></td>
<td><ul>
<li><a href="../carousel/examples/carousel-2-tablist.html">Auto-Rotating Image Carousel with Tabs for Slide Control</a> (HC)</li>
<li><a href="../tabs/examples/tabs-automatic.html">Tabs with Automatic Activation</a> (HC)</li>
<li><a href="../tabs/examples/tabs-manual.html">Tabs with Manual Activation</a> (HC)</li>
</ul></td>
</tr>
<tr class="even">
<td><code>toolbar</code></td>
<td><a href="../toolbar/examples/toolbar.html">Toolbar</a></td>
</tr>
<tr class="odd">
<td><code>tree</code></td>
<td><ul>
<li><a href="../treeview/examples/treeview-1a.html">File Directory Treeview Using Computed Properties</a></li>
<li><a href="../treeview/examples/treeview-1b.html">File Directory Treeview Using Declared Properties</a></li>
<li><a href="../treeview/examples/treeview-navigation.html">Navigation Treeview</a> (HC)</li>
</ul></td>
</tr>
<tr class="even">
<td><code>treegrid</code></td>
<td><a href="../treegrid/examples/treegrid-1.html">Treegrid Email Inbox</a></td>
</tr>
<tr class="odd">
<td><code>treeitem</code></td>
<td><ul>
<li><a href="../treeview/examples/treeview-1a.html">File Directory Treeview Using Computed Properties</a></li>
<li><a href="../treeview/examples/treeview-1b.html">File Directory Treeview Using Declared Properties</a></li>
<li><a href="../treeview/examples/treeview-navigation.html">Navigation Treeview</a> (HC)</li>
</ul></td>
</tr>
</tbody>
</table>



## Examples By Properties and States


**NOTE:** The HC abbreviation means example has High Contrast support.


<table class="data attributes" aria-labelledby="examples_by_props_label">
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr class="header">
<th>Property or State</th>
<th>Examples</th>
</tr>
</thead>
<tbody id="examples_by_props_tbody">
<tr class="odd">
<td><code>aria-activedescendant</code></td>
<td><ul>
<li><a href="../combobox/examples/combobox-autocomplete-both.html">Editable Combobox With Both List and Inline Autocomplete</a> (HC)</li>
<li><a href="../combobox/examples/combobox-autocomplete-list.html">Editable Combobox With List Autocomplete</a> (HC)</li>
<li><a href="../combobox/examples/combobox-autocomplete-none.html">Editable Combobox without Autocomplete</a> (HC)</li>
<li><a href="../combobox/examples/combobox-select-only.html">Select-Only Combobox</a></li>
<li><a href="../combobox/examples/grid-combo.html">Editable Combobox with Grid Popup</a></li>
<li><a href="../listbox/examples/listbox-collapsible.html">(Deprecated) Collapsible Dropdown Listbox</a></li>
<li><a href="../listbox/examples/listbox-grouped.html">Listbox with Grouped Options</a></li>
<li><a href="../listbox/examples/listbox-rearrangeable.html">Listboxes with Rearrangeable Options</a></li>
<li><a href="../listbox/examples/listbox-scrollable.html">Scrollable Listbox</a></li>
<li><a href="../menu-button/examples/menu-button-actions-active-descendant.html">Actions Menu Button Using aria-activedescendant</a> (HC)</li>
<li><a href="../radio/examples/radio-activedescendant.html">Radio Group Using aria-activedescendant</a> (HC)</li>
</ul></td>
</tr>
<tr class="even">
<td><code>aria-atomic</code></td>
<td><a href="../alert/examples/alert.html">Alert</a></td>
</tr>
<tr class="odd">
<td><code>aria-autocomplete</code></td>
<td><ul>
<li><a href="../combobox/examples/combobox-autocomplete-both.html">Editable Combobox With Both List and Inline Autocomplete</a> (HC)</li>
<li><a href="../combobox/examples/combobox-autocomplete-list.html">Editable Combobox With List Autocomplete</a> (HC)</li>
<li><a href="../combobox/examples/combobox-autocomplete-none.html">Editable Combobox without Autocomplete</a> (HC)</li>
<li><a href="../combobox/examples/combobox-datepicker.html">Date Picker Combobox</a> (HC)</li>
<li><a href="../combobox/examples/grid-combo.html">Editable Combobox with Grid Popup</a></li>
</ul></td>
</tr>
<tr class="even">
<td><code>aria-busy</code></td>
<td><a href="../feed/examples/feed.html">Infinite Scrolling Feed</a></td>
</tr>
<tr class="odd">
<td><code>aria-checked</code></td>
<td><ul>
<li><a href="../checkbox/examples/checkbox-mixed.html">Checkbox (Mixed-State)</a> (HC)</li>
<li><a href="../checkbox/examples/checkbox.html">Checkbox (Two State)</a> (HC)</li>
<li><a href="../menubar/examples/menubar-editor.html">Editor Menubar</a> (HC)</li>
<li><a href="../radio/examples/radio-activedescendant.html">Radio Group Using aria-activedescendant</a> (HC)</li>
<li><a href="../radio/examples/radio-rating.html">Rating Radio Group</a> (HC)</li>
<li><a href="../radio/examples/radio.html">Radio Group Using Roving tabindex</a> (HC)</li>
<li><a href="../switch/examples/switch-button.html">Switch Using HTML Button</a> (HC)</li>
<li><a href="../switch/examples/switch.html">Switch</a> (HC)</li>
<li><a href="../toolbar/examples/toolbar.html">Toolbar</a></li>
</ul></td>
</tr>
<tr class="even">
<td><code>aria-colcount</code></td>
<td><a href="../grid/examples/data-grids.html">Data Grid</a></td>
</tr>
<tr class="odd">
<td><code>aria-colindex</code></td>
<td><a href="../grid/examples/data-grids.html">Data Grid</a></td>
</tr>
<tr class="even">
<td><code>aria-controls</code></td>
<td><ul>
<li><a href="../accordion/examples/accordion.html">Accordion</a></li>
<li><a href="../carousel/examples/carousel-1-prev-next.html">Auto-Rotating Image Carousel with Buttons for Slide Control</a></li>
<li><a href="../carousel/examples/carousel-2-tablist.html">Auto-Rotating Image Carousel with Tabs for Slide Control</a> (HC)</li>
<li><a href="../checkbox/examples/checkbox-mixed.html">Checkbox (Mixed-State)</a> (HC)</li>
<li><a href="../combobox/examples/combobox-autocomplete-both.html">Editable Combobox With Both List and Inline Autocomplete</a> (HC)</li>
<li><a href="../combobox/examples/combobox-autocomplete-list.html">Editable Combobox With List Autocomplete</a> (HC)</li>
<li><a href="../combobox/examples/combobox-autocomplete-none.html">Editable Combobox without Autocomplete</a> (HC)</li>
<li><a href="../combobox/examples/combobox-datepicker.html">Date Picker Combobox</a> (HC)</li>
<li><a href="../combobox/examples/combobox-select-only.html">Select-Only Combobox</a></li>
<li><a href="../combobox/examples/grid-combo.html">Editable Combobox with Grid Popup</a></li>
<li><a href="../disclosure/examples/disclosure-card.html">Disclosure (Show/Hide) Card</a> (HC)</li>
<li><a href="../disclosure/examples/disclosure-faq.html">Disclosure (Show/Hide) for Answers to Frequently Asked Questions</a> (HC)</li>
<li><a href="../disclosure/examples/disclosure-image-description.html">Disclosure (Show/Hide) for Image Description</a> (HC)</li>
<li><a href="../disclosure/examples/disclosure-navigation-hybrid.html">Disclosure Navigation Menu with Top-Level Links</a></li>
<li><a href="../disclosure/examples/disclosure-navigation.html">Disclosure Navigation Menu</a> (HC)</li>
<li><a href="../menu-button/examples/menu-button-actions-active-descendant.html">Actions Menu Button Using aria-activedescendant</a> (HC)</li>
<li><a href="../menu-button/examples/menu-button-actions.html">Actions Menu Button Using element.focus()</a> (HC)</li>
<li><a href="../menu-button/examples/menu-button-links.html">Navigation Menu Button</a> (HC)</li>
<li><a href="../spinbutton/examples/quantity-spinbutton.html">Quantity Spin Button</a></li>
<li><a href="../tabs/examples/tabs-automatic.html">Tabs with Automatic Activation</a> (HC)</li>
<li><a href="../tabs/examples/tabs-manual.html">Tabs with Manual Activation</a> (HC)</li>
<li><a href="../toolbar/examples/toolbar.html">Toolbar</a></li>
</ul></td>
</tr>
<tr class="odd">
<td><code>aria-current</code></td>
<td><ul>
<li><a href="../breadcrumb/examples/breadcrumb.html">Breadcrumb</a></li>
<li><a href="../disclosure/examples/disclosure-navigation-hybrid.html">Disclosure Navigation Menu with Top-Level Links</a></li>
<li><a href="../disclosure/examples/disclosure-navigation.html">Disclosure Navigation Menu</a> (HC)</li>
<li><a href="../menubar/examples/menubar-navigation.html">Navigation Menubar</a> (HC)</li>
<li><a href="../treeview/examples/treeview-navigation.html">Navigation Treeview</a> (HC)</li>
</ul></td>
</tr>
<tr class="even">
<td><code>aria-describedby</code></td>
<td><ul>
<li><a href="../alertdialog/examples/alertdialog.html">Alert Dialog</a></li>
<li><a href="../combobox/examples/combobox-datepicker.html">Date Picker Combobox</a> (HC)</li>
<li><a href="../dialog-modal/examples/datepicker-dialog.html">Date Picker Dialog</a> (HC)</li>
<li><a href="../dialog-modal/examples/dialog.html">Modal Dialog</a></li>
<li><a href="../feed/examples/feed.html">Infinite Scrolling Feed</a></li>
<li><a href="../table/examples/table.html">Table</a></li>
</ul></td>
</tr>
<tr class="odd">
<td><code>aria-disabled</code></td>
<td><ul>
<li><a href="../alertdialog/examples/alertdialog.html">Alert Dialog</a></li>
<li><a href="../menubar/examples/menubar-editor.html">Editor Menubar</a> (HC)</li>
<li><a href="../spinbutton/examples/quantity-spinbutton.html">Quantity Spin Button</a></li>
<li><a href="../toolbar/examples/toolbar.html">Toolbar</a></li>
</ul></td>
</tr>
<tr class="even">
<td><code>aria-errormessage</code></td>
<td><a href="../spinbutton/examples/quantity-spinbutton.html">Quantity Spin Button</a></td>
</tr>
<tr class="odd">
<td><code>aria-expanded</code></td>
<td><ul>
<li><a href="../accordion/examples/accordion.html">Accordion</a></li>
<li><a href="../combobox/examples/combobox-autocomplete-both.html">Editable Combobox With Both List and Inline Autocomplete</a> (HC)</li>
<li><a href="../combobox/examples/combobox-autocomplete-list.html">Editable Combobox With List Autocomplete</a> (HC)</li>
<li><a href="../combobox/examples/combobox-autocomplete-none.html">Editable Combobox without Autocomplete</a> (HC)</li>
<li><a href="../combobox/examples/combobox-datepicker.html">Date Picker Combobox</a> (HC)</li>
<li><a href="../combobox/examples/combobox-select-only.html">Select-Only Combobox</a></li>
<li><a href="../combobox/examples/grid-combo.html">Editable Combobox with Grid Popup</a></li>
<li><a href="../disclosure/examples/disclosure-card.html">Disclosure (Show/Hide) Card</a> (HC)</li>
<li><a href="../disclosure/examples/disclosure-faq.html">Disclosure (Show/Hide) for Answers to Frequently Asked Questions</a> (HC)</li>
<li><a href="../disclosure/examples/disclosure-image-description.html">Disclosure (Show/Hide) for Image Description</a> (HC)</li>
<li><a href="../disclosure/examples/disclosure-navigation-hybrid.html">Disclosure Navigation Menu with Top-Level Links</a></li>
<li><a href="../disclosure/examples/disclosure-navigation.html">Disclosure Navigation Menu</a> (HC)</li>
<li><a href="../listbox/examples/listbox-collapsible.html">(Deprecated) Collapsible Dropdown Listbox</a></li>
<li><a href="../menu-button/examples/menu-button-actions-active-descendant.html">Actions Menu Button Using aria-activedescendant</a> (HC)</li>
<li><a href="../menu-button/examples/menu-button-actions.html">Actions Menu Button Using element.focus()</a> (HC)</li>
<li><a href="../menu-button/examples/menu-button-links.html">Navigation Menu Button</a> (HC)</li>
<li><a href="../menubar/examples/menubar-editor.html">Editor Menubar</a> (HC)</li>
<li><a href="../menubar/examples/menubar-navigation.html">Navigation Menubar</a> (HC)</li>
<li><a href="../toolbar/examples/toolbar.html">Toolbar</a></li>
<li><a href="../treegrid/examples/treegrid-1.html">Treegrid Email Inbox</a></li>
<li><a href="../treeview/examples/treeview-1a.html">File Directory Treeview Using Computed Properties</a></li>
<li><a href="../treeview/examples/treeview-1b.html">File Directory Treeview Using Declared Properties</a></li>
<li><a href="../treeview/examples/treeview-navigation.html">Navigation Treeview</a> (HC)</li>
</ul></td>
</tr>
<tr class="even">
<td><code>aria-haspopup</code></td>
<td><ul>
<li><a href="../combobox/examples/combobox-datepicker.html">Date Picker Combobox</a> (HC)</li>
<li><a href="../combobox/examples/grid-combo.html">Editable Combobox with Grid Popup</a></li>
<li><a href="../listbox/examples/listbox-collapsible.html">(Deprecated) Collapsible Dropdown Listbox</a></li>
<li><a href="../menu-button/examples/menu-button-actions-active-descendant.html">Actions Menu Button Using aria-activedescendant</a> (HC)</li>
<li><a href="../menu-button/examples/menu-button-actions.html">Actions Menu Button Using element.focus()</a> (HC)</li>
<li><a href="../menu-button/examples/menu-button-links.html">Navigation Menu Button</a> (HC)</li>
<li><a href="../menubar/examples/menubar-editor.html">Editor Menubar</a> (HC)</li>
<li><a href="../menubar/examples/menubar-navigation.html">Navigation Menubar</a> (HC)</li>
<li><a href="../toolbar/examples/toolbar.html">Toolbar</a></li>
</ul></td>
</tr>
<tr class="odd">
<td><code>aria-hidden</code></td>
<td><ul>
<li><a href="../button/examples/button_idl.html">Button (IDL Version)</a></li>
<li><a href="../listbox/examples/listbox-grouped.html">Listbox with Grouped Options</a></li>
<li><a href="../listbox/examples/listbox-rearrangeable.html">Listboxes with Rearrangeable Options</a></li>
<li><a href="../listbox/examples/listbox-scrollable.html">Scrollable Listbox</a></li>
<li><a href="../menubar/examples/menubar-editor.html">Editor Menubar</a> (HC)</li>
<li><a href="../slider-multithumb/examples/slider-multithumb.html">Horizontal Multi-Thumb Slider</a> (HC)</li>
<li><a href="../slider/examples/slider-color-viewer.html">Color Viewer Slider</a> (HC)</li>
<li><a href="../slider/examples/slider-rating.html">Rating Slider</a> (HC)</li>
<li><a href="../slider/examples/slider-seek.html">Media Seek Slider</a> (HC)</li>
<li><a href="../slider/examples/slider-temperature.html">Vertical Temperature Slider</a> (HC)</li>
<li><a href="../spinbutton/examples/datepicker-spinbuttons.html">(Deprecated) Date Picker Spin Button</a></li>
<li><a href="../spinbutton/examples/quantity-spinbutton.html">Quantity Spin Button</a></li>
<li><a href="../switch/examples/switch-button.html">Switch Using HTML Button</a> (HC)</li>
<li><a href="../switch/examples/switch-checkbox.html">Switch Using HTML Checkbox Input</a> (HC)</li>
<li><a href="../switch/examples/switch.html">Switch</a> (HC)</li>
<li><a href="../table/examples/sortable-table.html">Sortable Table</a> (HC)</li>
<li><a href="../toolbar/examples/toolbar.html">Toolbar</a></li>
</ul></td>
</tr>
<tr class="even">
<td><code>aria-invalid</code></td>
<td><a href="../spinbutton/examples/quantity-spinbutton.html">Quantity Spin Button</a></td>
</tr>
<tr class="odd">
<td><code>aria-label</code></td>
<td><ul>
<li><a href="../breadcrumb/examples/breadcrumb.html">Breadcrumb</a></li>
<li><a href="../carousel/examples/carousel-1-prev-next.html">Auto-Rotating Image Carousel with Buttons for Slide Control</a></li>
<li><a href="../carousel/examples/carousel-2-tablist.html">Auto-Rotating Image Carousel with Tabs for Slide Control</a> (HC)</li>
<li><a href="../combobox/examples/combobox-autocomplete-both.html">Editable Combobox With Both List and Inline Autocomplete</a> (HC)</li>
<li><a href="../combobox/examples/combobox-autocomplete-list.html">Editable Combobox With List Autocomplete</a> (HC)</li>
<li><a href="../combobox/examples/combobox-autocomplete-none.html">Editable Combobox without Autocomplete</a> (HC)</li>
<li><a href="../combobox/examples/combobox-datepicker.html">Date Picker Combobox</a> (HC)</li>
<li><a href="../dialog-modal/examples/datepicker-dialog.html">Date Picker Dialog</a> (HC)</li>
<li><a href="../link/examples/link.html">Link</a></li>
<li><a href="../menubar/examples/menubar-editor.html">Editor Menubar</a> (HC)</li>
<li><a href="../menubar/examples/menubar-navigation.html">Navigation Menubar</a> (HC)</li>
<li><a href="../radio/examples/radio-rating.html">Rating Radio Group</a> (HC)</li>
<li><a href="../slider-multithumb/examples/slider-multithumb.html">Horizontal Multi-Thumb Slider</a> (HC)</li>
<li><a href="../spinbutton/examples/datepicker-spinbuttons.html">(Deprecated) Date Picker Spin Button</a></li>
<li><a href="../table/examples/table.html">Table</a></li>
<li><a href="../toolbar/examples/toolbar.html">Toolbar</a></li>
<li><a href="../treegrid/examples/treegrid-1.html">Treegrid Email Inbox</a></li>
<li><a href="../treeview/examples/treeview-navigation.html">Navigation Treeview</a> (HC)</li>
</ul></td>
</tr>
<tr class="even">
<td><code>aria-labelledby</code></td>
<td><ul>
<li><a href="../accordion/examples/accordion.html">Accordion</a></li>
<li><a href="../alertdialog/examples/alertdialog.html">Alert Dialog</a></li>
<li><a href="../checkbox/examples/checkbox.html">Checkbox (Two State)</a> (HC)</li>
<li><a href="../combobox/examples/combobox-datepicker.html">Date Picker Combobox</a> (HC)</li>
<li><a href="../combobox/examples/combobox-select-only.html">Select-Only Combobox</a></li>
<li><a href="../combobox/examples/grid-combo.html">Editable Combobox with Grid Popup</a></li>
<li><a href="../dialog-modal/examples/datepicker-dialog.html">Date Picker Dialog</a> (HC)</li>
<li><a href="../dialog-modal/examples/dialog.html">Modal Dialog</a></li>
<li><a href="../feed/examples/feed.html">Infinite Scrolling Feed</a></li>
<li><a href="../grid/examples/data-grids.html">Data Grid</a></li>
<li><a href="../grid/examples/layout-grids.html">Layout Grid</a></li>
<li><a href="../listbox/examples/listbox-collapsible.html">(Deprecated) Collapsible Dropdown Listbox</a></li>
<li><a href="../listbox/examples/listbox-grouped.html">Listbox with Grouped Options</a></li>
<li><a href="../listbox/examples/listbox-rearrangeable.html">Listboxes with Rearrangeable Options</a></li>
<li><a href="../listbox/examples/listbox-scrollable.html">Scrollable Listbox</a></li>
<li><a href="../menu-button/examples/menu-button-actions-active-descendant.html">Actions Menu Button Using aria-activedescendant</a> (HC)</li>
<li><a href="../menu-button/examples/menu-button-actions.html">Actions Menu Button Using element.focus()</a> (HC)</li>
<li><a href="../menu-button/examples/menu-button-links.html">Navigation Menu Button</a> (HC)</li>
<li><a href="../menubar/examples/menubar-navigation.html">Navigation Menubar</a> (HC)</li>
<li><a href="../meter/examples/meter.html">Meter</a></li>
<li><a href="../radio/examples/radio-activedescendant.html">Radio Group Using aria-activedescendant</a> (HC)</li>
<li><a href="../radio/examples/radio-rating.html">Rating Radio Group</a> (HC)</li>
<li><a href="../radio/examples/radio.html">Radio Group Using Roving tabindex</a> (HC)</li>
<li><a href="../slider/examples/slider-color-viewer.html">Color Viewer Slider</a> (HC)</li>
<li><a href="../slider/examples/slider-rating.html">Rating Slider</a> (HC)</li>
<li><a href="../slider/examples/slider-seek.html">Media Seek Slider</a> (HC)</li>
<li><a href="../slider/examples/slider-temperature.html">Vertical Temperature Slider</a> (HC)</li>
<li><a href="../spinbutton/examples/datepicker-spinbuttons.html">(Deprecated) Date Picker Spin Button</a></li>
<li><a href="../switch/examples/switch-button.html">Switch Using HTML Button</a> (HC)</li>
<li><a href="../tabs/examples/tabs-automatic.html">Tabs with Automatic Activation</a> (HC)</li>
<li><a href="../tabs/examples/tabs-manual.html">Tabs with Manual Activation</a> (HC)</li>
<li><a href="../treeview/examples/treeview-1a.html">File Directory Treeview Using Computed Properties</a></li>
<li><a href="../treeview/examples/treeview-1b.html">File Directory Treeview Using Declared Properties</a></li>
<li><a href="../treeview/examples/treeview-navigation.html">Navigation Treeview</a> (HC)</li>
<li><a href="../landmarks/examples/complementary.html.html">Complementary Landmark</a></li>
<li><a href="../landmarks/examples/form.html.html">Form Landmark</a></li>
<li><a href="../landmarks/examples/main.html.html">Main Landmark</a></li>
<li><a href="../landmarks/examples/navigation.html.html">Navigation Landmark</a></li>
<li><a href="../landmarks/examples/region.html.html">Region Landmark</a></li>
<li><a href="../landmarks/examples/search.html.html">Search Landmark</a></li>
</ul></td>
</tr>
<tr class="odd">
<td><code>aria-level</code></td>
<td><ul>
<li><a href="../treegrid/examples/treegrid-1.html">Treegrid Email Inbox</a></li>
<li><a href="../treeview/examples/treeview-1b.html">File Directory Treeview Using Declared Properties</a></li>
</ul></td>
</tr>
<tr class="even">
<td><code>aria-live</code></td>
<td><ul>
<li><a href="../alert/examples/alert.html">Alert</a></li>
<li><a href="../carousel/examples/carousel-1-prev-next.html">Auto-Rotating Image Carousel with Buttons for Slide Control</a></li>
<li><a href="../carousel/examples/carousel-2-tablist.html">Auto-Rotating Image Carousel with Tabs for Slide Control</a> (HC)</li>
<li><a href="../combobox/examples/combobox-datepicker.html">Date Picker Combobox</a> (HC)</li>
<li><a href="../dialog-modal/examples/datepicker-dialog.html">Date Picker Dialog</a> (HC)</li>
</ul></td>
</tr>
<tr class="odd">
<td><code>aria-modal</code></td>
<td><ul>
<li><a href="../alertdialog/examples/alertdialog.html">Alert Dialog</a></li>
<li><a href="../combobox/examples/combobox-datepicker.html">Date Picker Combobox</a> (HC)</li>
<li><a href="../dialog-modal/examples/datepicker-dialog.html">Date Picker Dialog</a> (HC)</li>
<li><a href="../dialog-modal/examples/dialog.html">Modal Dialog</a></li>
</ul></td>
</tr>
<tr class="even">
<td><code>aria-multiselectable</code></td>
<td><a href="../listbox/examples/listbox-rearrangeable.html">Listboxes with Rearrangeable Options</a></td>
</tr>
<tr class="odd">
<td><code>aria-orientation</code></td>
<td><a href="../slider/examples/slider-temperature.html">Vertical Temperature Slider</a></td>
</tr>
<tr class="even">
<td><code>aria-owns</code></td>
<td><a href="../treeview/examples/treeview-navigation.html">Navigation Treeview</a></td>
</tr>
<tr class="odd">
<td><code>aria-posinset</code></td>
<td><ul>
<li><a href="../feed/examples/feed.html">Infinite Scrolling Feed</a></li>
<li><a href="../treegrid/examples/treegrid-1.html">Treegrid Email Inbox</a></li>
<li><a href="../treeview/examples/treeview-1b.html">File Directory Treeview Using Declared Properties</a></li>
</ul></td>
</tr>
<tr class="even">
<td><code>aria-pressed</code></td>
<td><ul>
<li><a href="../button/examples/button_idl.html">Button (IDL Version)</a></li>
<li><a href="../button/examples/button.html">Button</a></li>
<li><a href="../toolbar/examples/toolbar.html">Toolbar</a></li>
</ul></td>
</tr>
<tr class="odd">
<td><code>aria-roledescription</code></td>
<td><ul>
<li><a href="../carousel/examples/carousel-1-prev-next.html">Auto-Rotating Image Carousel with Buttons for Slide Control</a></li>
<li><a href="../carousel/examples/carousel-2-tablist.html">Auto-Rotating Image Carousel with Tabs for Slide Control</a> (HC)</li>
</ul></td>
</tr>
<tr class="even">
<td><code>aria-rowcount</code></td>
<td><ul>
<li><a href="../grid/examples/data-grids.html">Data Grid</a></li>
<li><a href="../grid/examples/layout-grids.html">Layout Grid</a></li>
</ul></td>
</tr>
<tr class="odd">
<td><code>aria-rowindex</code></td>
<td><ul>
<li><a href="../grid/examples/data-grids.html">Data Grid</a></li>
<li><a href="../grid/examples/layout-grids.html">Layout Grid</a></li>
</ul></td>
</tr>
<tr class="even">
<td><code>aria-selected</code></td>
<td><ul>
<li><a href="../carousel/examples/carousel-2-tablist.html">Auto-Rotating Image Carousel with Tabs for Slide Control</a> (HC)</li>
<li><a href="../combobox/examples/combobox-autocomplete-both.html">Editable Combobox With Both List and Inline Autocomplete</a> (HC)</li>
<li><a href="../combobox/examples/combobox-autocomplete-list.html">Editable Combobox With List Autocomplete</a> (HC)</li>
<li><a href="../combobox/examples/combobox-autocomplete-none.html">Editable Combobox without Autocomplete</a> (HC)</li>
<li><a href="../combobox/examples/combobox-datepicker.html">Date Picker Combobox</a> (HC)</li>
<li><a href="../combobox/examples/combobox-select-only.html">Select-Only Combobox</a></li>
<li><a href="../combobox/examples/grid-combo.html">Editable Combobox with Grid Popup</a></li>
<li><a href="../dialog-modal/examples/datepicker-dialog.html">Date Picker Dialog</a> (HC)</li>
<li><a href="../listbox/examples/listbox-collapsible.html">(Deprecated) Collapsible Dropdown Listbox</a></li>
<li><a href="../listbox/examples/listbox-grouped.html">Listbox with Grouped Options</a></li>
<li><a href="../listbox/examples/listbox-rearrangeable.html">Listboxes with Rearrangeable Options</a></li>
<li><a href="../listbox/examples/listbox-scrollable.html">Scrollable Listbox</a></li>
<li><a href="../tabs/examples/tabs-automatic.html">Tabs with Automatic Activation</a> (HC)</li>
<li><a href="../tabs/examples/tabs-manual.html">Tabs with Manual Activation</a> (HC)</li>
<li><a href="../treeview/examples/treeview-1a.html">File Directory Treeview Using Computed Properties</a></li>
<li><a href="../treeview/examples/treeview-1b.html">File Directory Treeview Using Declared Properties</a></li>
</ul></td>
</tr>
<tr class="odd">
<td><code>aria-setsize</code></td>
<td><ul>
<li><a href="../feed/examples/feed.html">Infinite Scrolling Feed</a></li>
<li><a href="../treegrid/examples/treegrid-1.html">Treegrid Email Inbox</a></li>
<li><a href="../treeview/examples/treeview-1b.html">File Directory Treeview Using Declared Properties</a></li>
</ul></td>
</tr>
<tr class="even">
<td><code>aria-sort</code></td>
<td><ul>
<li><a href="../grid/examples/data-grids.html">Data Grid</a></li>
<li><a href="../table/examples/sortable-table.html">Sortable Table</a> (HC)</li>
</ul></td>
</tr>
<tr class="odd">
<td><code>aria-valuemax</code></td>
<td><ul>
<li><a href="../meter/examples/meter.html">Meter</a></li>
<li><a href="../slider-multithumb/examples/slider-multithumb.html">Horizontal Multi-Thumb Slider</a> (HC)</li>
<li><a href="../slider/examples/slider-color-viewer.html">Color Viewer Slider</a> (HC)</li>
<li><a href="../slider/examples/slider-rating.html">Rating Slider</a> (HC)</li>
<li><a href="../slider/examples/slider-seek.html">Media Seek Slider</a> (HC)</li>
<li><a href="../slider/examples/slider-temperature.html">Vertical Temperature Slider</a> (HC)</li>
<li><a href="../spinbutton/examples/datepicker-spinbuttons.html">(Deprecated) Date Picker Spin Button</a></li>
<li><a href="../spinbutton/examples/quantity-spinbutton.html">Quantity Spin Button</a></li>
<li><a href="../toolbar/examples/toolbar.html">Toolbar</a></li>
</ul></td>
</tr>
<tr class="even">
<td><code>aria-valuemin</code></td>
<td><ul>
<li><a href="../meter/examples/meter.html">Meter</a></li>
<li><a href="../slider-multithumb/examples/slider-multithumb.html">Horizontal Multi-Thumb Slider</a> (HC)</li>
<li><a href="../slider/examples/slider-color-viewer.html">Color Viewer Slider</a> (HC)</li>
<li><a href="../slider/examples/slider-rating.html">Rating Slider</a> (HC)</li>
<li><a href="../slider/examples/slider-seek.html">Media Seek Slider</a> (HC)</li>
<li><a href="../slider/examples/slider-temperature.html">Vertical Temperature Slider</a> (HC)</li>
<li><a href="../spinbutton/examples/datepicker-spinbuttons.html">(Deprecated) Date Picker Spin Button</a></li>
<li><a href="../spinbutton/examples/quantity-spinbutton.html">Quantity Spin Button</a></li>
<li><a href="../toolbar/examples/toolbar.html">Toolbar</a></li>
</ul></td>
</tr>
<tr class="odd">
<td><code>aria-valuenow</code></td>
<td><ul>
<li><a href="../meter/examples/meter.html">Meter</a></li>
<li><a href="../slider-multithumb/examples/slider-multithumb.html">Horizontal Multi-Thumb Slider</a> (HC)</li>
<li><a href="../slider/examples/slider-color-viewer.html">Color Viewer Slider</a> (HC)</li>
<li><a href="../slider/examples/slider-rating.html">Rating Slider</a> (HC)</li>
<li><a href="../slider/examples/slider-seek.html">Media Seek Slider</a> (HC)</li>
<li><a href="../slider/examples/slider-temperature.html">Vertical Temperature Slider</a> (HC)</li>
<li><a href="../spinbutton/examples/datepicker-spinbuttons.html">(Deprecated) Date Picker Spin Button</a></li>
<li><a href="../spinbutton/examples/quantity-spinbutton.html">Quantity Spin Button</a></li>
<li><a href="../toolbar/examples/toolbar.html">Toolbar</a></li>
</ul></td>
</tr>
<tr class="even">
<td><code>aria-valuetext</code></td>
<td><ul>
<li><a href="../slider/examples/slider-rating.html">Rating Slider</a> (HC)</li>
<li><a href="../slider/examples/slider-seek.html">Media Seek Slider</a> (HC)</li>
<li><a href="../slider/examples/slider-temperature.html">Vertical Temperature Slider</a> (HC)</li>
<li><a href="../spinbutton/examples/datepicker-spinbuttons.html">(Deprecated) Date Picker Spin Button</a></li>
<li><a href="../toolbar/examples/toolbar.html">Toolbar</a></li>
</ul></td>
</tr>
</tbody>
</table>



## Experimental Examples


**NOTE:** The HC abbreviation means example has High Contrast support.


- [Experimental Scrollable Listbox with Actions on Options](../listbox/examples/listbox-actions.html)
- [Experimental Tabs with Action Buttons](../tabs/examples/tabs-actions.html) (HC)









<img src="data:image/svg+xml;base64,PHN2ZyBmb2N1c2FibGU9ImZhbHNlIiBhcmlhLWhpZGRlbj0idHJ1ZSIgY2xhc3M9Imljb24tY29tbWVudHMgIj48dXNlIHhsaW5rOmhyZWY9Ii9XQUkvYXNzZXRzL2ltYWdlcy9pY29ucy5zdmcjaWNvbi1jb21tZW50cyI+PC91c2U+PC9zdmc+" class="icon-comments" />

## Help improve this page



Please share your ideas, suggestions, or comments via e-mail to the publicly-archived list [public-aria-practices@w3.org](mailto:public-aria-practices@w3.org?body=%5Binclude%20a%20relevant%20email%20Subject%5D%0A%0A%5Bput%20comment%20here...%5D%0A%0A) or via GitHub.


<a href="mailto:public-aria-practices@w3.org?body=%5Binclude%20a%20relevant%20email%20Subject%5D%0A%0A%5Bput%20comment%20here...%5D%0A%0A" class="button"><span>E-mail</span></a><a href="%0Ahttps://github.com/w3c/aria-practices/edit/main/content/index/index.html%0A" class="button"><span>Fork &amp; Edit on GitHub</span></a><a href="https://github.com/w3c/aria-practices/issues/new?template=content-issue.yml&amp;wai-url=https://www.w3.org/WAI/ARIA/apg/example-index/" class="button"><span>New GitHub Issue</span></a>





<a href="#top" class="button button-backtotop"><span><img src="data:image/svg+xml;base64,PHN2ZyBmb2N1c2FibGU9ImZhbHNlIiBhcmlhLWhpZGRlbj0idHJ1ZSIgY2xhc3M9Imljb24tYXJyb3ctdXAgIj48dXNlIHhsaW5rOmhyZWY9Ii9XQUkvYXNzZXRzL2ltYWdlcy9pY29ucy5zdmcjaWNvbi1hcnJvdy11cCI+PC91c2U+PC9zdmc+" class="icon-arrow-up" /> Back to Top</span></a>




<a href="https://www.w3.org/WAI/" lang="en" dir="auto" translate="no">W3C Web Accessibility Initiative (WAI)</a>



Strategies, standards, resources to make the Web accessible to people with disabilities



- <img src="/WAI/assets/images/email.svg" class="w3c-icon w3c-icon--larger" aria-hidden="true" width="30" height="30" /> [Get News in Email](/WAI/news/subscribe/)
- <img src="/WAI/assets/images/social/linkedin.svg" class="w3c-icon w3c-icon--larger" aria-hidden="true" width="30" height="30" /> <a href="https://www.linkedin.com/company/w3c-wai/" translate="no">LinkedIn</a>
- <img src="https://www.w3.org/assets/website-2021/svg/mastodon.svg" class="w3c-icon w3c-icon--larger" aria-hidden="true" width="30" height="30" /> <a href="https://w3c.social/@wai" translate="no">Mastodon</a>
- <img src="/WAI/assets/images/social/youtube.svg" class="w3c-icon w3c-icon--larger" aria-hidden="true" width="30" height="30" /> <a href="https://www.youtube.com/channel/UCU6ljj3m1fglIPjSjs2DpRA/playlists/" translate="no">YouTube</a>





- [Home](/WAI/)
- [Contact](/WAI/about/contacting/)
- [Site map](/WAI/sitemap/)
- [Support WAI](/WAI/about/support/)
- [News](/WAI/news/)
- [Accessibility statement](/WAI/about/accessibility-statement/)
- [All Translations](/WAI/translations/)
- [Resources for roles](/WAI/roles/)



Copyright © 2026 [World Wide Web Consortium](https://www.w3.org/).  
W3C<sup>®</sup> [liability](https://www.w3.org/policies/#disclaimers), [trademark](https://www.w3.org/policies/#trademarks) and <a href="https://www.w3.org/copyright/software-license/" rel="license" title="W3C Software License">permissive license</a> rules apply unless otherwise noted. See [Permission to Use WAI Material](/WAI/about/using-wai-material/).

