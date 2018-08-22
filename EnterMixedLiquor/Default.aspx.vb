
Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Xml.Linq
Imports System.Collections.Generic
Imports System.Data
Imports System.Net
Imports System.IO
Imports System.Runtime.Serialization.Json
Imports System.Runtime.Serialization.Formatters
Imports System.Text
Imports System.Diagnostics

Partial Class _Default
    Inherits System.Web.UI.Page

    Public oAuthClientId As String = "819027772449-2us5mt2tu1ec84nve9353qka8i6mfj68.apps.googleusercontent.com"
    Public oAuthClientSecret As String = "HE9RS70btK6bwiMty2waAtDm"
		
    '--------------------------------------------------------------------------------------------
    'PAGE LOAD
    '--------------------------------------------------------------------------------------------
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        AuthenticateUser()
    End Sub

    Public Sub AuthenticateUser()

        '`````````````````````````````````````````````````````````````
        '&code parameter IS in the url
        '`````````````````````````````````````````````````````````````
        If Not Request.QueryString("code") Is Nothing Then

            'We are on a bounce-back from the provider's login page. Use the &code value to get a new Access_token and Refresh_token. 
            Dim _oauthresponse As String = GetOauthTokensFromProvider(Request.QueryString("code"))
            StoreOauthTokensInSessionVariables(_oauthresponse)
            
            'Re-load the page with the original url to remove the &code parameter
            Response.Redirect(Session("OriginalUrl"))
        
        '`````````````````````````````````````````````````````````````
        '&code parameter is NOT in the url
        '`````````````````````````````````````````````````````````````
        Else
            Session("OriginalUrl") = Request.Url.AbsoluteUri.ToString().ToLower
            If Session("accesstoken") Is Nothing Then                         
                SendUserToOauthProviderAuthorizationPage()
            Else     
                'Inject a <script> tag in the client to pass the OAUTH object to javascript.
                Dim cs As ClientScriptManager = Page.ClientScript
                Dim js as [String] = [String].Format( _
                    "<script>history.pushState({{}}, '', '{0}'); var OAUTH={{'access_token':'{1}','email_address':'{2}','refresh_token':'{3}','expires_in':'{4}','client_id':'{5}','client_secret':'{6}'}};</script>", _
                    Session("OriginalUrl"),Session("accesstoken"),Session("emailaddress"),Session("refreshtoken"),Session("expirationinseconds"),oAuthClientId,oAuthClientSecret _
                )
                cs.RegisterStartupScript(Me.GetType(),"oauthscript",js)
            End If
        End If
    End Sub

    Public Function GetOauthTokensFromProvider(ByVal _code As String) As String
        Dim _oauth As New oAuthService
        Dim _tokenResponse As String = ""
        Dim oAuthQueryString_Code As String = _code
        Dim oAuthRedirectUrl As String = Request.Url.AbsoluteUri.ToString.ToLower.Split("?")(0)
        _tokenResponse = _oauth.GetToken( _
            code:=oAuthQueryString_Code, _
            clientID:=oAuthClientId, _
            clientSecret:=oAuthClientSecret, _
            redirectURIs:=oAuthRedirectUrl, _
            refreshToken:=Session("refreshtoken") _            
        )
        Return _tokenResponse
    End Function

    Public Sub StoreOauthTokensInSessionVariables(ByVal _tokenResponse As String)
        '_googleResponse = {0}accesstoken|{1}refreshtoken|{2}expirationinseconds|{3}emailaddress
        Session("accesstoken") = _tokenResponse.Split("|")(0)
        Session("refreshtoken") = _tokenResponse.Split("|")(1)
        Session("expirationinseconds") = _tokenResponse.Split("|")(2)
        Session("emailaddress") = _tokenResponse.Split("|")(3)
		
		'Cookie to store the refresh_token
		If getLocalCookieValue("google_refresh_token") = "" Then
			Response.Cookies("google_refresh_token").Value = Session("refreshtoken")
			Response.Cookies("google_refresh_token").Expires = DateTime.Now.AddDays(365)
		End If
    End Sub

    Public Sub SendUserToOauthProviderAuthorizationPage()
        Dim url As String = "https://accounts.google.com/o/oauth2/auth?response_type=code"
        url += "&scope="
        url += "https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email+"
        url += "https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.profile"
        url += "&redirect_uri=" & Request.Url.AbsoluteUri.ToString.ToLower.Split("?")(0)
        url += "&client_id=" & oAuthClientId
        url += "&access_type=offline"
        Response.Redirect(url)
    End Sub
	
	Public Function getLocalCookieValue(ByVal cookieName As String) As String
        Dim i As Integer
        Dim val As String = ""
        Dim aCookie As HttpCookie

        For i = 0 To Request.Cookies.Count - 1
            aCookie = Request.Cookies(i)
            If aCookie.Name = cookieName Then
                val = aCookie.Value
            End If
        Next

        Return val
    End Function
End Class







Public Class oAuthService
    Inherits System.Web.Services.WebService

    Public Function GetToken(ByVal code As String, ByVal clientID As String, ByVal clientSecret As String, ByVal redirectURIs As String, ByVal refreshToken As String) As String

        Dim gId As New GoogleId()
        Dim emailAddress As String
        Dim _token As String = ""
        Dim _refreshtoken As String = ""
        Dim _expirationseconds As String = ""

        'Validate the authorization code received and pass back to google
        Dim responseFromServer As New GoogleResponse()
        Dim requestToken As HttpWebRequest = DirectCast(WebRequest.Create("https://accounts.google.com/o/oauth2/token"), HttpWebRequest)
        requestToken.Method = "POST"
        Dim postData As [String] = ""

        'What type of oauth method are we going to use? Original user-authorization CODE or an existing REFRESH_TOKEN?
        If refreshToken = "" Then
            postData = [String].Format( _
                "code={0}&client_id={1}&client_secret={2}&redirect_uri={3}&grant_type=authorization_code", _
                code, clientID, clientSecret, redirectURIs _
            )
        Else
            postData = [String].Format( _
                "refresh_token={0}&client_id={1}&client_secret={2}&redirect_uri={3}&grant_type=refresh_token", _
                refreshToken, clientID, clientSecret, redirectURIs _
            )
        End If

        'the token endpoint will respond with a JSON array that describes the token or an error.
        Dim byteArray As Byte() = Encoding.UTF8.GetBytes(postData)
        requestToken.ContentType = "application/x-www-form-urlencoded"
        requestToken.ContentLength = byteArray.Length

        Using dataStream As Stream = requestToken.GetRequestStream()
            dataStream.Write(byteArray, 0, byteArray.Length)
            dataStream.Close()
            Dim response As WebResponse = requestToken.GetResponse()
            If DirectCast(response, HttpWebResponse).StatusCode = HttpStatusCode.OK Then
                Using reader As New StreamReader(response.GetResponseStream())
                    responseFromServer = Deserialise(Of GoogleResponse)(reader.ReadToEnd())
                    reader.Close()
                    dataStream.Close()
                    response.Close()
                End Using
            Else
                emailAddress = "Error: Google denied your email request"
                dataStream.Close()

                response.Close()
            End If
        End Using

        If responseFromServer IsNot Nothing AndAlso Not String.IsNullOrEmpty(responseFromServer.access_token) Then
            _token = responseFromServer.access_token
            _refreshtoken = responseFromServer.refresh_token
            _expirationseconds = responseFromServer.expires_in

            'second validation
            'after google returns an access token send access token back to Google to get user's basic profile information
            Dim url As String = [String].Format("https://www.googleapis.com/oauth2/v1/userinfo?access_token={0}", responseFromServer.access_token)
            Dim requestUserInfo As HttpWebRequest = DirectCast(WebRequest.Create(url), HttpWebRequest)
            Dim responseUserInfo As HttpWebResponse = DirectCast(requestUserInfo.GetResponse(), HttpWebResponse)
            If DirectCast(responseUserInfo, HttpWebResponse).StatusCode = HttpStatusCode.OK Then
                Using receiveStream As Stream = responseUserInfo.GetResponseStream()
                    Dim encode As Encoding = System.Text.Encoding.GetEncoding("utf-8")
                    Using readStream As New StreamReader(receiveStream, encode)
                        ' puts information into appropriate fields in GoogleId class
                        gId = Deserialise(Of GoogleId)(readStream.ReadToEnd())
                        responseUserInfo.Close()
                        readStream.Close()
                        emailAddress = gId.email
                    End Using
                End Using

            End If
        End If

        Return _token & "|" & _refreshtoken & "|" & _expirationseconds & "|" & gId.email

    End Function

    Public Shared Function Deserialise(Of T)(ByVal json As String) As T
        Using ms = New MemoryStream(Encoding.Unicode.GetBytes(json))
            Dim serialiser = New DataContractJsonSerializer(GetType(T))
            Return DirectCast(serialiser.ReadObject(ms), T)
        End Using
    End Function
    Public Class GoogleResponse
        Public Property access_token() As [String]
            Get
                Return m_access_token
            End Get
            Set(ByVal value As [String])
                m_access_token = value
            End Set
        End Property
        Private m_access_token As [String]
        Public Property refresh_token() As [String]
            Get
                Return m_refresh_token
            End Get
            Set(ByVal value As [String])
                m_refresh_token = value
            End Set
        End Property
        Private m_refresh_token As [String]
        Public Property expires_in() As [String]
            Get
                Return m_expires_in
            End Get
            Set(ByVal value As [String])
                m_expires_in = value
            End Set
        End Property
        Private m_expires_in As [String]
        Public Property token_type() As [String]
            Get
                Return m_token_type
            End Get
            Set(ByVal value As [String])
                m_token_type = value
            End Set
        End Property
        Private m_token_type As [String]
    End Class
    Public Class GoogleId
        Public Property id() As [String]
            Get
                Return m_id
            End Get
            Set(ByVal value As [String])
                m_id = value
            End Set
        End Property
        Private m_id As [String]
        Public Property email() As [String]
            Get
                Return m_email
            End Get
            Set(ByVal value As [String])
                m_email = value
            End Set
        End Property
        Private m_email As [String]
        Public Property verified_email() As [Boolean]
            Get
                Return m_verified_email
            End Get
            Set(ByVal value As [Boolean])
                m_verified_email = value
            End Set
        End Property
        Private m_verified_email As [Boolean]
        Public Property name() As [String]
            Get
                Return m_name
            End Get
            Set(ByVal value As [String])
                m_name = value
            End Set
        End Property
        Private m_name As [String]
        Public Property given_name() As [String]
            Get
                Return m_given_name
            End Get
            Set(ByVal value As [String])
                m_given_name = value
            End Set
        End Property
        Private m_given_name As [String]
        Public Property family_name() As [String]
            Get
                Return m_family_name
            End Get
            Set(ByVal value As [String])
                m_family_name = value
            End Set
        End Property
        Private m_family_name As [String]
        Public Property link() As [String]
            Get
                Return m_link
            End Get
            Set(ByVal value As [String])
                m_link = value
            End Set
        End Property
        Private m_link As [String]
        Public Property picture() As [String]
            Get
                Return m_picture
            End Get
            Set(ByVal value As [String])
                m_picture = value
            End Set
        End Property
        Private m_picture As [String]
        Public Property gender() As [String]
            Get
                Return m_gender
            End Get
            Set(ByVal value As [String])
                m_gender = value
            End Set
        End Property
        Private m_gender As [String]
        Public Property locale() As [String]
            Get
                Return m_locale
            End Get
            Set(ByVal value As [String])
                m_locale = value
            End Set
        End Property
        Private m_locale As [String]
    End Class
	
	
End Class


