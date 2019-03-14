pragma solidity ^0.4.16;

contract blogFactory {
    address[] public deployedBlogs;
    function createBlog(string _title, string _blogHash, string _blogTime) public{
        address newBlog = new BlogDemo(_title, msg.sender, _blogHash, _blogTime);
        deployedBlogs.push(newBlog);
    }
    function getDeployedBlogs() public view returns(address[]) {
        return deployedBlogs;
    }
}
contract BlogDemo{
    //mapping(uint => Blog) public blog; 
    address public blogAuthor;
    string public blogTitle;
    uint public blogVoteCount;
    string public blogHash;
    string public blogTime;
    uint blogToken;
    
    mapping(address => bool) public voters;
    address[] public votersS;
    struct Voters{
        address creator;
        uint voteCount;
        bool isLiked;
        mapping(address => bool) votes;
    }
    
    Voters[] public votes;

    function BlogDemo(string _title, address _author, string _blogHash, string _blogTime) public {
        blogTitle = _title;
        blogAuthor = _author;
        blogHash = _blogHash;
        blogTime = _blogTime;
        blogVoteCount = 0;
        
        //blogCount += 1;
        //_time = now;
        //blog[blogCount]  = Blog(blogAuthor, blogTitle);
    }
    
    function upVote() public{
        require(voters[msg.sender] == false);
        voters[msg.sender] = true;
        blogVoteCount += 1;
        votersS.push(msg.sender);
        blogToken = generateToken(blogVoteCount);
    }
    
    function generateToken(uint _voteCount) public view returns(uint) {
         blogToken = _voteCount / 2;
         return blogToken;
    }
    
    function getSummary() public view returns(address, string, string, string, uint ,address[]) {
        return(
                blogAuthor,
                blogTitle,
                blogHash,
                blogTime,
                blogToken,
                votersS
            );
    }
       
}