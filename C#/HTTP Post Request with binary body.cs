using System.Text;

string url = "<ENDPOINT URL>";
string in_referralPDFLocation = @"<FILE PTH>";

string username = "<USERNAME>";
string password = "<PASSWORD>";

string responseBody;
int responseStatus = 0;

Byte[] byteFile = File.ReadAllBytes(in_referralPDFLocation);

using( HttpClient client = new HttpClient())
{
    ByteArrayContent content = new ByteArrayContent(byteFile);
    content.Headers.Add("content-type", "application/pdf");
    client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Basic",
        Convert.ToBase64String(Encoding.UTF8.GetBytes($"{username}:{password}")));
    HttpResponseMessage response = client.PostAsync(url, content).Result;
    responseStatus = (int)response.StatusCode;
    response.EnsureSuccessStatusCode();
    responseBody = response.Content.ReadAsStringAsync().Result;
}


Console.WriteLine(responseBody);
Console.WriteLine(responseStatus);